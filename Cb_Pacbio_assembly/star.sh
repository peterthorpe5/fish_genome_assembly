#!/bin/bash
#$ -cwd
cd /storage/home/users/pjt6/pb_fish/RNAseq

#java -jar /shelf/training/Trimmomatic-0.38/trimmomatic-0.38.jar PE -summary trim_summary.txt  -threads 32 -phred33 all_4stages_Gros_rnaseq_1.fq.gz  all_4stages_Gros_rnaseq_2.fq.gz   R1.fq.gz crap1.fastq.gz R2.fq.gz  crap2.fastq.gz ILLUMINACLIP:/shelf/training/Trimmomatic-0.38/adapters/TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:25 MINLEN:57

module load samtools
rm -rf star_indicies
mkdir star_indicies

# index the genome
/shelf/apps/pjt6/apps/STAR-master/bin/Linux_x86_64_static/STAR --runMode genomeGenerate --runThreadN 20 --limitGenomeGenerateRAM 259760745173 --genomeDir ./star_indicies --genomeFastaFiles /storage/home/users/pjt6/pb_fish/RNAseq/Crenichthys_baileyi.v1.0.softmasked_tantan.fasta 


/shelf/apps/pjt6/apps/STAR-master/bin/Linux_x86_64_static/STAR --genomeDir star_indicies/  --runThreadN 16 --readFilesCommand zcat --outSAMtype BAM SortedByCoordinate --readFilesIn  R1.fq.gz R2.fq.gz --outFilterMultimapNmax 1  --outFileNamePrefix cb --outFilterMismatchNmax 4   --limitBAMsortRAM 285554136874 
wait
samtools index cbAligned.sortedByCoord.out.bam


echo "Running transrate to get RNAseq mapping and it will tell you 
statistically what genes may be fusions. "
tran="transrate 
--threads 16
	 --assembly 
	 --left R1.fq.gz 
	 --right R2.fq.gz"
echo ${tran}
#eval ${tran}