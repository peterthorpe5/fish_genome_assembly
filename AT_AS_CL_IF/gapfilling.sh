#!/bin/bash -l
#SBATCH -J CL   #jobname
#SBATCH --partition=long
#SBATCH --cpus-per-task=32
#SBATCH --mem=70GB
conda activate gappadder

cd /mnt/shared/scratch/pthorpe/private/assemblies/CL
THREADS=32

# dna mapper need uncompressed files
pigz -p $THREADS -d R2.fq.gz 
pigz -p $THREADS -d R1.fq.gz 

#bwa 1 fails with the fish genomes. 
/home/pthorpe/apps/bwa-mem2//bwa-mem2 index scaffolds.fasta

/home/pthorpe/apps/bwa-mem2//bwa-mem2 mem -t $THREADS scaffolds.fasta R1.fq R2.fq > CL.sam

samtools view -@ $THREADS -S -b -o alnunsorted.bam CL.sam
#needs to be sorted
samtools sort -@ $THREADS -o  sorted.bam alnunsorted.bam
mv sorted.bam.bam sorted.bam
samtools index sorted.bam

# run the gappadder
python /home/pthorpe/apps/GAPPadder//main.py -c Preprocess -g configuration.json 

python /home/pthorpe/apps/GAPPadder//main.py -c Collect -g configuration.json 

python /home/pthorpe/apps/GAPPadder//main.py -c Assembly -g configuration.json

python /home/pthorpe/apps/GAPPadder//main.py -c Clean -g configuration.json
 
 