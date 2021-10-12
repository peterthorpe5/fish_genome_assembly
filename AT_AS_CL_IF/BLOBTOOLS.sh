#!/bin/bash -l
#SBATCH -J blob   #jobname
#SBATCH --partition=long
#SBATCH --cpus-per-task=30
#SBATCH --mem=60GB

cd /mnt/shared/scratch/pthorpe/private/assemblies/$1

GENOME=$1
PREFIX=${GENOME}_before_blobs.fasta
THREADS=30

conda activate blobtools

pigz -d -p $THREADS ec_R1.fq.gz
pigz -d -p $THREADS ec_R2.fq.gz


bwa-mem2 index ${PREFIX}
bwa-mem2 mem  -o temp.sam -t $THREADS ${PREFIX}  ec_R1.fq ec_R2.fq  

######################################
export export BLASTDB=//mnt/shared/apps/databases/diamond/

blastn -task megablast -query ${PREFIX} -db nt -outfmt '6 qseqid staxids bitscore std scomnames sscinames sblastnames sskingdoms stitle' -evalue 1e-50 -out n.clc.allfinal.out -num_threads $THREADS

blobtools create -i ${PREFIX}  -s temp.sam -t n.clc.allfinal.out -o n${PREFIX}.blobplots
 
 mkdir allfinal.fa.blobplots
 cp n${PREFIX}.blobplots.blobDB.json ./allfinal.fa.blobplots
 
blobtools view -i  n${PREFIX}.blobplots.blobDB.json -o allfinal.fa.blobplots/
 
blobtools blobplot -i n${PREFIX}.blobplots.blobDB.json -o allfinal.fa.blobplots/ 

#rm temp.sam

cd allfinal.fa.blobplots
    cat *.blobDB.table.txt | grep "Streptophyta" | cut -f1 > Streptophyta.names
    cat *.blobDB.table.txt | grep "Arthropoda" | cut -f1 > Arthropoda.names
    cat *.blobDB.table.txt | grep "Ascomycota" | cut -f1 > Ascomycota.names
    #cat *.blobDB.table.txt | grep "Chordata" | cut -f1 > Chordata.names
    #cat *.blobDB.table.txt | grep "Nematoda" | cut -f1 > Nematoda.names
    cat *.blobDB.table.txt | grep "Basidiomycota" | cut -f1 > Basidiomycota.names
    cat *.blobDB.table.txt | grep "Proteobacteria" | cut -f1 > Proteobacteria.names
    cat *.blobDB.table.txt | grep "Bacteria-undef" | cut -f1 > Bacteria-undef.names
    cat *.blobDB.table.txt | grep "Viruses-undef" | cut -f1 > Viruses-undef.names
    #cat *.blobDB.table.txt | grep "Cnidaria" | cut -f1 > Cnidaria.names
    cat *.blobDB.table.txt | grep "Actinobacteria" | cut -f1 > Actinobacteria.names
    cat *.blobDB.table.txt | grep "Mucoromycota" | cut -f1 > Mucoromycota.names
    cat *.blobDB.table.txt | grep "Euryarchaeota" | cut -f1 > Euryarchaeota.names 
    cat *.blobDB.table.txt | awk '$5 < 5' | grep 'no-hit' | sort -k4 -rn | cut -f1 > low_cov_5.LOOKATME
    cat *.names >  bad_contigs.out
cat *.names >  bad_contigs.out

cd ../

python /mnt/shared/scratch/pthorpe/private/assemblies/get_sequences_i_want_from_fasta_command_line_not_wanted_file.py ${PREFIX} ./allfinal.fa.blobplots/bad_contigs.out 1000 ${PREFIX}.contim_filtered_final.fasta
rm temp.sam

