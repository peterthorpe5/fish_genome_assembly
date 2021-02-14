#!/bin/bash -l
#SBATCH -J cb_pilon   #jobname
#SBATCH --partition=long
#SBATCH --cpus-per-task=60
#SBATCH -p himem
#SBATCH --mem=2900GB


cd  /home/pthorpe/scratch/cb/pilon
#conda activate funannotate

 #funannotate sort -i  cb.contim_filtered_final.fasta -o cb_beforepilon.fasta -b gr

# conda to activate the software
echo $PATH
conda activate pilon1.23


THREADS=28

############################################################################################################################################################
# pilon Illumina polishing-pacbio-assemblies-with-arrow-and-pilon/

##############################################################
##################################################
# pilon 1

PREFIX=cb_contigs.fasta

PILITERNUM=1

#minimap2 -t $THREADS -ax map-ont cb_beforepilon.fasta /home/pthorpe/scratch/cb/raw_reads.fasta > aln.sam
#wait
#samtools view -@ $THREADS -S -b -o alnunsorted.bam aln.sam
#wait
#samtools sort -@ $THREADS -o  sorted_mini2.bam alnunsorted.bam
#samtools index sorted_mini2.bam
#
#pigz -d -p $THREADS /home/pthorpe/scratch/cb/pilon/R1.fq.gz 
#pigz -d -p $THREADS /home/pthorpe/scratch/cb/pilon/R2.fq.gz 
#bwa-mem2 index cb_beforepilon.fasta
#bwa-mem2 mem  -o new.illumina.mapped.sam -t $THREADS cb_beforepilon.fasta  /home/pthorpe/scratch/cb/pilon/R1.fq /home/pthorpe/scratch/cb/pilon/R2.fq  
#
#samtools view -@ $THREADS -S -b -o new.illumina.temp.mapped.bam new.illumina.mapped.sam
#samtools sort -@ $THREADS -o  new.illumina.mapped.bam new.illumina.temp.mapped.bam
#rm new.illumina.temp.mapped.bam new.illumina.mapped.sam
#samtools index new.illumina.mapped.bam

# this has been through one iteration. Now use the ouptu from iteration 1 for the new error correction. 
# old way = java -Xmx235G -jar ~/scratch/Downloads/pilon-1.22.jar
#pilon --genome cb_beforepilon.fasta --bam new.illumina.mapped.bam --pacbio sorted_mini2.bam --changes --vcf --diploid --threads $THREADS --output cb_Illumina_pilon_iter1


##################################################
# pilon 2

#PILITERNUM=2
#
#minimap2 -t $THREADS -ax map-pb cb_Illumina_pilon_iter1.fasta /home/pthorpe/scratch/cb/raw_reads.fasta > aln.sam
#samtools view -@ $THREADS -S -b -o alnunsorted.bam aln.sam
wait
#samtools sort -@ $THREADS -o  sorted_mini2.bam alnunsorted.bam
#samtools index sorted_mini2.bam

#bwa-mem2 index cb_Illumina_pilon_iter1.fasta
#bwa-mem2 mem  -o new.illumina.mapped.sam -t $THREADS cb_Illumina_pilon_iter1.fasta R1.fq R2.fq 

#samtools view -@ $THREADS -S -b -o new.illumina.temp.mapped.bam new.illumina.mapped.sam
#samtools sort -@ $THREADS -o  new.illumina.mapped.bam new.illumina.temp.mapped.bam

#samtools index new.illumina.mapped.bam
#rm new.illumina.temp.mapped.bam new.illumina.mapped.sam

# this has been through one iteration. Now use the ouptu from iteration 1 for the new error correction. 
pilon --genome cb_Illumina_pilon_iter1.fasta --bam new.illumina.mapped.bam --pacbio sorted_mini2.bam --changes --vcf --diploid --threads 60 --output cb_Illumina_pilon_iter2


##################################################
# pilon 3

PILITERNUM=3

minimap2 -t $THREADS -ax map-pb cb_Illumina_pilon_iter2.fasta /home/pthorpe/scratch/cb/raw_reads.fasta > aln.sam
samtools view -@ $THREADS -S -b -o alnunsorted.bam aln.sam
wait
samtools sort -@ $THREADS -o  sorted_mini2.bam alnunsorted.bam
samtools index sorted_mini2.bam
bwa-mem2 index cb_Illumina_pilon_iter2.fasta
bwa-mem2 mem  -o new.illumina.mapped.sam -t $THREADS cb_Illumina_pilon_iter2.fasta R1.fq R2.fq 

samtools view -@ $THREADS -S -b -o new.illumina.temp.mapped.bam new.illumina.mapped.sam
samtools sort -@ $THREADS -o  new.illumina.mapped.bam new.illumina.temp.mapped.bam
samtools index new.illumina.mapped.bam
rm new.illumina.temp.mapped.bam new.illumina.mapped.sam

# this has been through one iteration. Now use the ouptu from iteration 1 for the new error correction. 
pilon --genome cb_Illumina_pilon_iter2.fasta --bam new.illumina.mapped.bam --pacbio sorted_mini2.bam --changes --vcf --diploid --threads 60 --output cb_Illumina_pilon_iter3



##################################################
PILITERNUM=4

minimap2 -t $THREADS -ax map-pb cb_Illumina_pilon_iter3.fasta /home/pthorpe/scratch/cb/raw_reads.fasta > aln.sam
samtools view -@ $THREADS -S -b -o alnunsorted.bam aln.sam
wait
samtools sort -@ $THREADS -o  sorted_mini2.bam alnunsorted.bam
samtools index sorted_mini2.bam

bwa-mem2 index cb_Illumina_pilon_iter3.fasta
bwa-mem2 mem  -o new.illumina.mapped.sam -t $THREADS cb_Illumina_pilon_iter3.fasta R1.fq R2.fq 

samtools view -@ $THREADS -S -b -o new.illumina.temp.mapped.bam new.illumina.mapped.sam
samtools sort -@ $THREADS -o  new.illumina.mapped.bam new.illumina.temp.mapped.bam
samtools index new.illumina.mapped.bam

rm new.illumina.temp.mapped.bam new.illumina.mapped.sam

# this has been through one iteration. Now use the ouptu from iteration 1 for the new error correction. 
pilon --genome cb_Illumina_pilon_iter3.fasta --bam new.illumina.mapped.bam --pacbio sorted_mini2.bam --changes --vcf --diploid --threads 60 --output cb_Illumina_pilon_iter4

#################################################
PILITERNUM=5

minimap2 -t $THREADS -ax map-pb cb_Illumina_pilon_iter4.fasta /home/pthorpe/scratch/cb/raw_reads.fasta > aln.sam
samtools view -@ $THREADS -S -b -o alnunsorted.bam aln.sam
wait
samtools sort -@ $THREADS -o  sorted_mini2.bam alnunsorted.bam
samtools index sorted_mini2.bam

bwa-mem2 index cb_Illumina_pilon_iter4.fasta
bwa-mem2 mem  -o new.illumina.mapped.sam -t $THREADS cb_Illumina_pilon_iter4.fasta R1.fq R2.fq 
#
samtools view -@ $THREADS -S -b -o new.illumina.temp.mapped.bam new.illumina.mapped.sam
samtools sort -@ $THREADS -o  new.illumina.mapped.bam new.illumina.temp.mapped.bam
#
samtools index new.illumina.mapped.bam
rm new.illumina.temp.mapped.bam new.illumina.mapped.sam

# this has been through one iteration. Now use the ouptu from iteration 1 for the new error correction. 
pilon --genome cb_Illumina_pilon_iter4.fasta --bam new.illumina.mapped.bam --pacbio sorted_mini2.bam --changes --vcf --diploid --threads $THREADS --output cb_Illumina_pilon_iter5

exit
##################################################
PILITERNUM=6

minimap2 -t $THREADS -ax map-pb cb_Illumina_pilon_iter5.fasta /home/pthorpe/scratch/cb/raw_reads.fasta > aln.sam
samtools view -@ $THREADS -S -b -o alnunsorted.bam aln.sam
wait
samtools sort -@ $THREADS -o  sorted_mini2.bam alnunsorted.bam
samtools index sorted_mini2.bam

bwa-mem2 index cb_Illumina_pilon_iter5.fasta
bwa-mem2 mem  -o new.illumina.mapped.sam -t $THREADS cb_Illumina_pilon_iter5.fasta R1.fq R2.fq 

samtools view -@ $THREADS -S -b -o new.illumina.temp.mapped.bam new.illumina.mapped.sam
samtools sort -@ $THREADS -o  new.illumina.mapped.bam new.illumina.temp.mapped.bam
samtools index new.illumina.mapped.bam

rm new.illumina.temp.mapped.bam new.illumina.mapped.sam

# this has been through one iteration. Now use the ouptu from iteration 1 for the new error correction. 
pilon --genome cb_Illumina_pilon_iter5.fasta --bam new.illumina.mapped.bam --pacbio sorted_mini2.bam --changes --vcf --diploid --threads $THREADS --output cb_Illumina_pilon_iter6

conda activate funannotate

 funannotate sort -i cb_Illumina_pilon_iter5.fasta -o Crenichthys_baileyi.v1.0.fasta  -b CBSF
#squeue --wrap "funannotate sort -i cb_Illumina_pilon_iter5.fasta -o cb.v1.0.fasta  -b CBSF"
#################################################
# Haplotype phasing
##################################################
PILITERNUM=7

#conda activate haplo_phase
#
#minimap2 -t $THREADS -ax map-pb cb_Illumina_pilon_iter5.fasta /home/pthorpe/scratch/cb/raw_reads.fasta > aln2.sam
#samtools view -@ $THREADS -S -b -o alnunsorted2.bam aln2.sam
wait
#samtools sort -@ $THREADS -o  sorted_mini3.bam alnunsorted2.bam
#samtools index sorted_mini3.bam
#
#bwa-mem2 index cb_Illumina_pilon_iter5.fasta
#bwa-mem2 mem  -o new.illumina.mapped.sam -t $THREADS cb_Illumina_pilon_iter5.fasta R1.fq \
#R2.fq > new.illumina.mapped2.sam
#
#samtools view -@ $THREADS -S -b -o new.illumina.temp.mapped2.bam new.illumina.mapped2.sam
#samtools sort -@ $THREADS -o  new.illumina.mapped2.bam new.illumina.temp.mapped2.bam
#samtools index new.illumina.mapped2.bam
#
#
###################################################
## now for haplotype phasing
#
###################################################
## now for haplotype phasing
#
#
#
##module load freebayes/gitv1_8d2b3a0
#
#freebayes -f cb_Illumina_pilon_iter5.fasta --no-population-priors --min-alternate-count 5 --min-alternate-fraction 0.9 -v cb_illumina.vcf \
#--ploidy 2 new.illumina.mapped2.bam
#
#conda activate 
#cp sorted_mini3.bam pacbio.bam
#whatshap phase --ignore-read-groups -o phased.vcf input.vcf pacbio.bam
#