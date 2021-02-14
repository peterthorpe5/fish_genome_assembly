#!/bin/bash -l
#SBATCH -J Cb_pilon   #jobname
#SBATCH -N 1     #node
#SBATCH --ntasks-per-node=48
#SBATCH --threads-per-core=2
#SBATCH -p himem
#SBATCH --mem=1460GB


cd  /mnt/shared/scratch/pthorpe/private/cb

# conda to activate the software
echo $PATH
conda activate pilon1.23


THREADS=48

echo $PATH

# this has been through one iteration. Now use the ouptu from iteration 1 for the new error correction. 
#pigz --d *.gz


PREFIX=Cb_V1.0.fasta

PILITERNUM=1


##################################################
# pilon 1

PILITERNUM=1


#bwa index Cb_V1.0.fasta

pigz -d -p $THREADS R1_paired.fq.gz 
wait
pigz -d -p $THREADS R2_paired.fq.gz
wait
bwa mem -t $THREADS  Cb_V1.0.fasta R1_paired.fq R2_paired.fq > new.illumina.mapped.sam

samtools view -@ $THREADS -S -b -o new.illumina.temp.mapped.bam new.illumina.mapped.sam
samtools sort -@ $THREADS -o  new.illumina.mapped.bam new.illumina.temp.mapped.bam

samtools index new.illumina.mapped.bam
rm new.illumina.temp.mapped.bam new.illumina.mapped.sam

# this has been through one iteration. Now use the ouptu from iteration 1 for the new error correction. 
pilon --genome Cb_V1.0.fasta --bam new.illumina.mapped.bam --changes --vcf --diploid --threads $THREADS --output Cb_pilon_iter2


##################################################
# pilon 3

PILITERNUM=3

bwa index Cb_pilon_iter2.fasta
bwa mem -t $THREADS Cb_pilon_iter2.fasta R1_paired.fq R2_paired.fq > new.illumina.mapped.sam

samtools view -@ $THREADS -S -b -o new.illumina.temp.mapped.bam new.illumina.mapped.sam
samtools sort -@ $THREADS -o  new.illumina.mapped.bam new.illumina.temp.mapped.bam
samtools index new.illumina.mapped.bam
rm new.illumina.temp.mapped.bam new.illumina.mapped.sam

# this has been through one iteration. Now use the ouptu from iteration 1 for the new error correction. 
pilon --genome Cb_pilon_iter2.fasta --bam new.illumina.mapped.bam --changes --vcf --diploid --threads $THREADS --output Cb_pilon_iter3



##################################################
PILITERNUM=4


bwa index Cb_pilon_iter3.fasta
bwa mem -t $THREADS Cb_pilon_iter3.fasta R1_paired.fq R2_paired.fq > new.illumina.mapped.sam

samtools view -@ $THREADS -S -b -o new.illumina.temp.mapped.bam new.illumina.mapped.sam
samtools sort -@ $THREADS -o  new.illumina.mapped.bam new.illumina.temp.mapped.bam
samtools index new.illumina.mapped.bam

rm new.illumina.temp.mapped.bam new.illumina.mapped.sam

# this has been through one iteration. Now use the ouptu from iteration 1 for the new error correction. 
pilon --genome Cb_pilon_iter3.fasta --bam new.illumina.mapped.bam --changes --vcf --diploid --threads $THREADS --output Cb_pilon_iter4


pigz -p $THREADS  R1_paired.fq 
pigz -p $THREADS  R2_paired.fq
