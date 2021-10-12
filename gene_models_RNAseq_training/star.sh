#!/bin/bash -l
#SBATCH -J XC_STAR   #jobname
#SBATCH --partition=long
#SBATCH --cpus-per-task=26
#SBATCH --mem=89GB
cd /mnt/shared/scratch/pthorpe/private/gene_annotations/$1

rm -rf star_indicies
mkdir star_indicies

# index the genome
/home/pthorpe/apps/STAR-master/bin/Linux_x86_64_static/STAR --runMode genomeGenerate --runThreadN 26 --limitGenomeGenerateRAM 259760745173 \
--genomeDir ./star_indicies --genomeFastaFiles *.fasta.tantan


/home/pthorpe/apps/STAR-master/bin/Linux_x86_64_static/STAR --genomeDir star_indicies/ --limitGenomeGenerateRAM 85554136874 \
--runThreadN 26 --readFilesCommand zcat --outSAMtype BAM SortedByCoordinate --readFilesIn  R1.fq.gz R2.fq.gz \
--outFilterMultimapNmax 1  --outFileNamePrefix $1 --outFilterMismatchNmax 4 --limitBAMsortRAM 85554136874 
