#!/bin/bash
#$ -cwd
cd /storage/home/users/Michael_Ritchie/gene_annotation/$1


trimmomatic PE -summary trim_summary.txt  -threads 32 -phred33 r1.fq.gz  r2.fq.gz   R1.fq.gz crap1.fastq.gz R2.fq.gz  crap2.fastq.gz ILLUMINACLIP:/shelf/training/Trimmomatic-0.38/adapters/TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:30 MINLEN:47

#module load samtools
rm -rf star_indicies
mkdir star_indicies

# index the genome
/shelf/apps/pjt6/apps/STAR-master/bin/Linux_x86_64_static/STAR --runMode genomeGenerate --runThreadN 32 --limitGenomeGenerateRAM 259760745173 \
--genomeDir ./star_indicies --genomeFastaFiles *.fasta


/shelf/apps/pjt6/apps/STAR-master/bin/Linux_x86_64_static/STAR --genomeDir star_indicies/ --limitGenomeGenerateRAM 285554136874 --runThreadN 32 --readFilesCommand zcat --outSAMtype BAM SortedByCoordinate --readFilesIn  bbnorm_R1.fq.gz bbnorm_R2.fq.gz --outFilterMultimapNmax 1  --outFileNamePrefix $1_bb --outFilterMismatchNmax 4 --limitBAMsortRAM 285554136874 
wait
 Trinity --genome_guided_bam $1_bb*.bam   --genome_guided_max_intron 15000  --CPU 32 --max_memory 120G --output bb_Trinity --genome_guided_min_coverage 4

echo "Running transrate to get RNAseq mapping and it will tell you 
statistically what genes may be fusions. "
tran="transrate 
--threads 16
	 --assembly ./ass_Trinity/Trinity-GG.fasta
	 --left R1.fq.gz 
	 --right R2.fq.gz"
echo ${tran}
eval ${tran}

echo "Running transrate to get RNAseq mapping and it will tell you 
statistically what genes may be fusions. "
tran="transrate 
--threads 16
	 --assembly ./transrate_results/Trinity-GG/good.Trinity-GG.fasta
	 --left R1.fq.gz 
	 --right R2.fq.gz"
echo ${tran}
eval ${tran}