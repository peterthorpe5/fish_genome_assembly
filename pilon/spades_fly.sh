#!/bin/bash -l
#SBATCH -J SPADES_cb   #jobname
#SBATCH -N 1     #node
#SBATCH --tasks-per-node=24
#SBATCH -p bigmem
#SBATCH --nodelist=kennedy150
#SBATCH --mem=1250GB

cd /gpfs1/home/pjt6/scratch

echo $PATH
conda activate spades


# run the assembly with 1.45 TB RAM. 64 threads
#spades.py -o fly_clc  \
#-1 /gpfs1/scratch/bioinf/pjt6/R1_paired.fq.gz \
#-2 /gpfs1/scratch/bioinf/pjt6/R2_paired.fq.gz \
#-k 55,77,99,117,125 \
#--trusted-contigs /gpfs1/scratch/bioinf/pjt6/fly.clc.EC.fa -t 24 -m 1450 

spades.py -o fly_clc2  --only-assembler \
-1 /gpfs1/scratch/bioinf/pjt6/fly_clc/corrected/R1_paired.fq.00.0_0.cor.fastq.gz \
-2 /gpfs1/scratch/bioinf/pjt6/fly_clc/corrected/R2_paired.fq.00.0_0.cor.fastq.gz \
-k 33,55,77 \
--trusted-contigs /gpfs1/home/pjt6/trusted.fasta -t 24 -m 1250 


conda deactivate 
echo $PATH
conda activate python27

echo $PATH
