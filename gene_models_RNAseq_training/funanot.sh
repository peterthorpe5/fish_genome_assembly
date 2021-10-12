#!/bin/bash -l
#SBATCH -J XC_funan   #jobname
#SBATCH --partition=long
#SBATCH --cpus-per-task=26
#SBATCH --mem=80GB
cd /home/pthorpe/scratch/gene_annotations/XC
conda activate funannotate1.8.7

###########################
# variables
genome="Xc_V1.1.softmasked.fasta"
threads=26
left="R1.fq.gz"
right="R2.fq.gz"
name="XENOCAPTIV"
species="Xenoophorus_captivus" # two words
strain="V.1.0" # ,ust put a strain
out_folder="XC_funannotate"
max_intron_len=15000
RM_lib="consensi.fa.classified"


################################
#GPAL_newton_softmasked

# 1) # rename the scafold and sort by length
#funannotate clean -i ${genome} --minlen 1000 -o ${genome}.cleaned.fa  

# 2) sort by length
#funannotate sort -i${genome}.cleaned.fa -b scaffold -o ${genome}.cleaned.sorted.fa  

# 3) mask
#funannotate mask -i ${genome}.cleaned.sorted.fa --cpus ${threads} -o MyAssembly.fa  --repeatmodeler_lib ${RM_lib}
#funannotate mask -i ${genome} -o ${genome}.tantan --cpus ${threads} 

 
# 4) train. run trinity and pasa. # if you have stranded --stranded RF,  tight gene density --jaccard_clip,  --nanopore_mrna nanopore_mRNA.fq.gz
# no enough ram on this machine to run trinity
train="funannotate train 
    -i ${genome}.tantan -o ${out_folder} --left ${left}  --right ${right} 
	--trinity trinity.fasta --species ${species} --cpus ${threads} 
	--strain ${strain} --max_intronlen ${max_intron_len}  
    --TRINITYHOME /mnt/shared/scratch/pthorpe/apps/conda/envs/funannotate/bin/Trinity"
echo ${train}
#eval ${train}

 have to run TE beofre now:
 
 #tRNAscan-SE -o cb_funannotate/predict_misc/tRNAscan.out --thread 30 /mnt/shared/scratch/pthorpe/private/cb/final/cb_funannotate/predict_misc/genome.softmasked.fa -S off


# 5) predict genes - it will know where to look for the out files form the other runs. --organism other (for non fungal)
# thi one is default. 

# cat *fasta_tRNAscan.out > ../cb_funannotate/predict_misc/tRNAscan.out

predict=" funannotate predict
-i ${genome}.tantan -o ${out_folder} 
    --species  ${species} 
    --strain ${strain} --cpus ${threads} 
    --max_intronlen ${max_intron_len} 
    --organism other 
    --busco_db  eukaryota
    --name ${name}
    --ploidy 2
    --weights codingquarry:0 glimmerhmm:0  snap:0 genemark:0
    --optimize_augustus
	--organism other --augustus_species XC_PASA2
	--rna_bam *.bam
    --SeqCenter SEQ_CENTR_TO_BE_FILLED_IN
    --keep_evm
"
echo ${predict} 
eval ${predict}
	
	# possible run with this option --repeats2evm

# 6) if have RNAseq update with get the UTR predctions.
funannotate update --left_norm bbnorm_R1.fq.gz --right_norm bbnorm_R2.fq.gz --no_trimmomatic --no_normalize_reads -i ${out_folder} --cpus ${threads} --max_intronlen  15000 --TRINITYHOME /mnt/shared/scratch/pthorpe/apps/conda/envs/funannotate/bin/Trinity

#funannotate util gff2tbl --gff3 GROS_renamed.gff3  -f GROS_nanopore_v1.0.softmasked.fasta > GROS.tbl

#funannotate util tbl2gbk -i GROS.tbl -f GROS_nanopore_v1.0.softmasked.fasta -s GROS -o GROS


#funannotate remote -m phobius -e pjt6@st-andrews.ac.uk -g GROS.gbk -o phobius

#/home/pthorpe/scratch/ros/RNAseq/funannotate-1.5.3/funannotate remote -m  interproscan  -e pjt6@st-andrews.ac.uk -g GROS.gbk -o interproscan --force


 annot="funannotate annotate
-i ${genome} 
-o annot 
    --species  ${species} 
    --strain ${strain} 
    --cpus ${threads} 
    --busco_db  eukaryota
"
echo ${annot} 
eval ${annot}
