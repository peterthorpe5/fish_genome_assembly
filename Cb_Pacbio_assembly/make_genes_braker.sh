#!/bin/bash -l
#SBATCH -J BrFunan   #jobname
#SBATCH --partition=long
#SBATCH --cpus-per-task=30
#SBATCH --mem=60GB
cd /home/pthorpe/scratch/cb/final
conda activate funannotate

###########################
# variables
genome="Crenichthys_baileyi.v1.0.softmasked_tantan.fasta"
threads=30
left="R1.fq.gz"
right="R2.fq.gz"
name="CRENBAI"
species="Crenichthys_baileyi" # two words
strain="V.1.0" # ,ust put a strain
out_folder="Fun_braker"
max_intron_len=15000
RM_lib="consensi.fa.classified"

#cp /home/pthorpe/scratch/cb/final/tRNAscan.out tRNAscan.out

################################
#GPAL_newton_softmasked

# 1) # rename the scafold and sort by length
#funannotate clean -i ${genome} --minlen 1000 -o ${genome}.cleaned.fa  

# 2) sort by length
#funannotate sort -i${genome}.cleaned.fa -b scaffold -o ${genome}.cleaned.sorted.fa  

# 3) mask
#funannotate mask -i ${genome}.cleaned.sorted.fa --cpus ${threads} -o MyAssembly.fa  --repeatmodeler_lib ${RM_lib}

 
# 4) train. run trinity and pasa. # if you have stranded --stranded RF,  tight gene density --jaccard_clip,  --nanopore_mrna nanopore_mRNA.fq.gz
# no enough ram on this machine to run trinity
train="/home/pthorpe/scratch/cb/final/funannotate-1.8.3/scripts/funannotate train -i ${genome} -o ${out_folder} --left ${left}  --right ${right} \
	--trinity good.good.Trinity-GG.fasta --species ${species} --cpus ${threads} \
	--strain ${strain} --max_intronlen ${max_intron_len}  
    --TRINITYHOME /mnt/shared/scratch/pthorpe/apps/conda/envs/funannotate/bin/Trinity"
echo ${train}
#eval ${train}


 
 #tRNAscan-SE -o cb_funannotate/predict_misc/tRNAscan.out --thread 30 /mnt/shared/scratch/pthorpe/private/cb/final/cb_funannotate/predict_misc/genome.softmasked.fa -S off


# 5) predict genes - it will know where to look for the out files form the other runs. --organism other (for non fungal)
# thi one is default. 
predict="/home/pthorpe/scratch/cb/final/funannotate-1.8.3/funannotate/predict.py 
    -i ${genome} -o ${out_folder} 
    --species  ${species}
    --strain ${strain} 
    --cpus ${threads} 
    --max_intronlen ${max_intron_len} 
    --organism other 
    --busco_db  eukaryota
    --name ${name}
    --ploidy 2
    --weights glimmerhmm:0 codingquarry:0
	--organism other 
	--rna_bam cbAligned.sortedByCoord.out.bam
    --augustus_species Crenichthys_baileyi_BUSCO2
    --genemark_gtf  /home/pthorpe/scratch/cb/final/genemark.gtf
    --other_gff /home/pthorpe/scratch/cb/final/braker2/augustus.hints_utr.gff3:4
    --keep_evm
"
echo ${predict} 
#eval ${predict}

	
	# possible run with this option --repeats2evm

# 6) if have RNAseq update with get the UTR predctions.
/home/pthorpe/scratch/cb/final/funannotate-1.8.3/scripts/funannotate update --left_norm bbnomr_R1.fq.gz --right_norm bbnomr_R2.fq.gz --no_trimmomatic --no_normalize_reads -i ${out_folder} --cpus ${threads} --max_intronlen  15000 --TRINITYHOME /mnt/shared/scratch/pthorpe/apps/conda/envs/funannotate/bin/Trinity


#funannotate util gff2tbl --gff3 GROS_renamed.gff3  -f GROS_nanopore_v1.0.softmasked.fasta > GROS.tbl

#funannotate util tbl2gbk -i GROS.tbl -f GROS_nanopore_v1.0.softmasked.fasta -s GROS -o GROS


#funannotate remote -m phobius -e pjt6@st-andrews.ac.uk -g GROS.gbk -o phobius

#/home/pthorpe/scratch/ros/RNAseq/funannotate-1.5.3/funannotate remote -m  interproscan  -e pjt6@st-andrews.ac.uk -g GROS.gbk -o interproscan --force

#funannotate annotate  --phobius /mnt/shared/scratch/pthorpe/private/ros/RNAseq/phobius.out --species Globodera_rostociensis --strain rostoch --cpu 12  --out annotate --genbank GROS.gbk --busco_db eukaryota --database ~/apps/funannotate_db/

 

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
