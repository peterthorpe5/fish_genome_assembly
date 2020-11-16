#!/bin/bash -l
#SBATCH -J Xr_pilon   #jobname
#SBATCH -N 1     #node
#SBATCH --ntasks-per-node=48
#SBATCH --threads-per-core=2
#SBATCH -p bigmem
#SBATCH --nodelist=kennedy150
#SBATCH --mem=1350GB


cd  /home/pjt6/scratch/Xr_S_M_M6_2_DNA

# conda to activate the software
echo $PATH
conda activate pilon1.23


THREADS=48

echo $PATH

# this has been through one iteration. Now use the ouptu from iteration 1 for the new error correction. 
#pigz --d *.gz


PREFIX=xr_pilon1.fasta

PILITERNUM=1


##################################################
# pilon 1

PILITERNUM=1


bwa index xr_pilon1.fasta

pigz -d -p $THREADS R1_paired.fq.gz 
pigz -d -p $THREADS R2_paired.fq.gz
bwa mem -t $THREADS  xr_pilon1.fasta R1_paired.fq R2_paired.fq > new.illumina.mapped.sam

samtools view -@ $THREADS -S -b -o new.illumina.temp.mapped.bam new.illumina.mapped.sam
samtools sort -@ $THREADS -o  new.illumina.mapped.bam new.illumina.temp.mapped.bam

samtools index new.illumina.mapped.bam
rm new.illumina.temp.mapped.bam new.illumina.mapped.sam

# this has been through one iteration. Now use the ouptu from iteration 1 for the new error correction. 
pilon --genome xr_pilon1.fasta --bam new.illumina.mapped.bam --changes --vcf --diploid --threads $THREADS --output Xr_pilon_iter2


##################################################
# pilon 3

PILITERNUM=3

bwa index Xr_pilon_iter2.fasta
bwa mem -t $THREADS Xr_pilon_iter2.fasta R1_paired.fq R2_paired.fq > new.illumina.mapped.sam

samtools view -@ $THREADS -S -b -o new.illumina.temp.mapped.bam new.illumina.mapped.sam
samtools sort -@ $THREADS -o  new.illumina.mapped.bam new.illumina.temp.mapped.bam
samtools index new.illumina.mapped.bam
rm new.illumina.temp.mapped.bam new.illumina.mapped.sam

# this has been through one iteration. Now use the ouptu from iteration 1 for the new error correction. 
pilon --genome Xr_pilon_iter2.fasta --bam new.illumina.mapped.bam --changes --vcf --diploid --threads $THREADS --output Xr_pilon_iter3



##################################################
PILITERNUM=4


bwa index Xr_pilon_iter3.fasta
bwa mem -t $THREADS Xr_pilon_iter3.fasta R1_paired.fq R2_paired.fq > new.illumina.mapped.sam

samtools view -@ $THREADS -S -b -o new.illumina.temp.mapped.bam new.illumina.mapped.sam
samtools sort -@ $THREADS -o  new.illumina.mapped.bam new.illumina.temp.mapped.bam
samtools index new.illumina.mapped.bam

rm new.illumina.temp.mapped.bam new.illumina.mapped.sam

# this has been through one iteration. Now use the ouptu from iteration 1 for the new error correction. 
pilon --genome Xr_pilon_iter3.fasta --bam new.illumina.mapped.bam --changes --vcf --diploid --threads $THREADS --output Xr_pilon_iter4


pigz -p $THREADS  R1_paired.fq 
pigz -p $THREADS  R2_paired.fq
