#!/bin/bash -l
#SBATCH -J pilon   #jobname
#SBATCH --partition=long
#SBATCH --cpus-per-task=24
#SBATCH -p himem
#SBATCH --mem=1450GB

GENOME=$1
PREFIX=${GENOME}_SS2.fasta.final.scaffolds.fasta
THREADS=24

cd  /home/pthorpe/scratch/assemblies/${GENOME}

# conda to activate the software
conda activate pilon1.23

# this has been through one iteration. Now use the ouptu from iteration 1 for the new error correction. 
#pigz -p $THREADS -d ec_R1.fq.gz
#pigz -p $THREADS -d ec_R2.fq.gz


PILITERNUM=1


##################################################
# pilon 1

PILITERNUM=1


#bwa-mem2 index ${PREFIX}
#bwa-mem2 mem  -o new.illumina.mapped.sam -t $THREADS ${PREFIX}  /home/pthorpe/scratch/assemblies/${GENOME}/ec_R1.fq /home/pthorpe/scratch/assemblies/${GENOME}/ec_R2.fq  

#samtools view -@ $THREADS -S -b -o new.illumina.temp.mapped.bam new.illumina.mapped.sam
#samtools sort -@ $THREADS -o  new.illumina.mapped.bam new.illumina.temp.mapped.bam
#rm new.illumina.temp.mapped.bam new.illumina.mapped.sam
#samtools index new.illumina.mapped.bam

pilon --genome ${PREFIX} --bam new.illumina.mapped.bam  --changes --vcf --diploid --threads $THREADS --output ${GENOME}_Illumina_pilon_iter1


##################################################
# pilon 2

#PILITERNUM=2


bwa-mem2 index ${GENOME}_Illumina_pilon_iter1.fasta
bwa-mem2 mem  -o new.illumina.mapped.sam -t $THREADS ${GENOME}_Illumina_pilon_iter1.fasta ec_R1.fq ec_R2.fq 

samtools view -@ $THREADS -S -b -o new.illumina.temp.mapped.bam new.illumina.mapped.sam
samtools sort -@ $THREADS -o  new.illumina.mapped.bam new.illumina.temp.mapped.bam

samtools index new.illumina.mapped.bam
rm new.illumina.temp.mapped.bam new.illumina.mapped.sam

# this has been through one iteration. Now use the ouptu from iteration 1 for the new error correction. 
pilon --genome ${GENOME}_Illumina_pilon_iter1.fasta --bam new.illumina.mapped.bam  --changes --vcf --diploid --threads 60 --output ${GENOME}_Illumina_pilon_iter2


##################################################
# pilon 3

PILITERNUM=3


bwa-mem2 index ${GENOME}_Illumina_pilon_iter2.fasta
bwa-mem2 mem  -o new.illumina.mapped.sam -t $THREADS ${GENOME}_Illumina_pilon_iter2.fasta ec_R1.fq ec_R2.fq 

samtools view -@ $THREADS -S -b -o new.illumina.temp.mapped.bam new.illumina.mapped.sam
samtools sort -@ $THREADS -o  new.illumina.mapped.bam new.illumina.temp.mapped.bam
samtools index new.illumina.mapped.bam
rm new.illumina.temp.mapped.bam new.illumina.mapped.sam

# this has been through one iteration. Now use the ouptu from iteration 1 for the new error correction. 
pilon --genome ${GENOME}_Illumina_pilon_iter2.fasta --bam new.illumina.mapped.bam  --changes --vcf --diploid --threads 60 --output ${GENOME}_Illumina_pilon_iter3



##################################################
PILITERNUM=4



bwa-mem2 index ${GENOME}_Illumina_pilon_iter3.fasta
bwa-mem2 mem  -o new.illumina.mapped.sam -t $THREADS ${GENOME}_Illumina_pilon_iter3.fasta ec_R1.fq ec_R2.fq 

samtools view -@ $THREADS -S -b -o new.illumina.temp.mapped.bam new.illumina.mapped.sam
samtools sort -@ $THREADS -o  new.illumina.mapped.bam new.illumina.temp.mapped.bam
samtools index new.illumina.mapped.bam

rm new.illumina.temp.mapped.bam new.illumina.mapped.sam

# this has been through one iteration. Now use the ouptu from iteration 1 for the new error correction. 
pilon --genome ${GENOME}_Illumina_pilon_iter3.fasta --bam new.illumina.mapped.bam  --changes --vcf --diploid --threads 60 --output ${GENOME}_Illumina_pilon_iter4

#################################################
PILITERNUM=5



bwa-mem2 index ${GENOME}_Illumina_pilon_iter4.fasta
bwa-mem2 mem  -o new.illumina.mapped.sam -t $THREADS ${GENOME}_Illumina_pilon_iter4.fasta ec_R1.fq ec_R2.fq 
#
samtools view -@ $THREADS -S -b -o new.illumina.temp.mapped.bam new.illumina.mapped.sam
samtools sort -@ $THREADS -o  new.illumina.mapped.bam new.illumina.temp.mapped.bam
#
samtools index new.illumina.mapped.bam
rm new.illumina.temp.mapped.bam new.illumina.mapped.sam

# this has been through one iteration. Now use the ouptu from iteration 1 for the new error correction. 
pilon --genome ${GENOME}_Illumina_pilon_iter4.fasta --bam new.illumina.mapped.bam  --changes --vcf --diploid --threads $THREADS --output ${GENOME}_Illumina_pilon_iter5

exit
##################################################
PILITERNUM=6


bwa-mem2 index ${GENOME}_Illumina_pilon_iter5.fasta
bwa-mem2 mem  -o new.illumina.mapped.sam -t $THREADS ${GENOME}_Illumina_pilon_iter5.fasta ec_R1.fq ec_R2.fq 

samtools view -@ $THREADS -S -b -o new.illumina.temp.mapped.bam new.illumina.mapped.sam
samtools sort -@ $THREADS -o  new.illumina.mapped.bam new.illumina.temp.mapped.bam
samtools index new.illumina.mapped.bam

rm new.illumina.temp.mapped.bam new.illumina.mapped.sam

# this has been through one iteration. Now use the ouptu from iteration 1 for the new error correction. 
pilon --genome ${GENOME}_Illumina_pilon_iter5.fasta --bam new.illumina.mapped.bam  --changes --vcf --diploid --threads $THREADS --output ${GENOME}_Illumina_pilon_iter6

conda activate funannotate

 funannotate sort -i ${GENOME}_Illumina_pilon_iter5.fasta -o ${GENOME}.v1.0.fasta  -b ${GENOME}SF
