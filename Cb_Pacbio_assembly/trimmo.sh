#!/bin/bash
#$ -cwd
cd /storage/home/users/pjt6/pb_fish/RNAseq


java -jar /shelf/training/Trimmomatic-0.38/trimmomatic-0.38.jar PE -summary trim_summary.txt  -threads 80 -phred33 r1.fq.gz  r2.fq.gz   R1.fq.gz crap1.fastq.gz R2.fq.gz  crap2.fastq.gz ILLUMINACLIP:/shelf/training/Trimmomatic-0.38/adapters/TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:47

#module load samtools
#mkdir star_indicies

# index the genome
#/shelf/apps/pjt6/apps/STAR-master/bin/Linux_x86_64_static/STAR --runMode genomeGenerate --runThreadN 32 --limitGenomeGenerateRAM 259760745173 \
#--genomeDir ./star_indicies --genomeFastaFiles cb_Illumina_pilon_iter4.fasta


/shelf/apps/pjt6/apps/STAR-master/bin/Linux_x86_64_static/STAR --genomeDir star_indicies/ --limitGenomeGenerateRAM 285554136874 --runThreadN 32 --readFilesCommand zcat --outSAMtype BAM SortedByCoordinate --readFilesIn  R1.fq.gz R2.fq.gz --outFilterMultimapNmax 3  --outFileNamePrefix cb --outFilterMismatchNmax 7 --limitBAMsortRAM 285554136874 
wait
 Trinity --genome_guided_bam cb*.bam   --genome_guided_max_intron 15000  --CPU 32 --max_memory 260G --output cb_Trinity --genome_guided_min_coverage 4

pigz -d R2.fq.gz
pigz -d R1.fq.gz

/storage/home/users/pjt6/shelf_apps/apps/bwa-mem2-2.0pre2_x64-linux/bwa-mem2 index cb_Illumina_pilon_iter4.fasta

/storage/home/users/pjt6/shelf_apps/apps/bwa-mem2-2.0pre2_x64-linux/bwa-mem2 mem -t 32 cb_Illumina_pilon_iter4.fasta  ../R1.fq ../R2.fq > ros.sam

/usr/local/Modules/modulefiles/tools/samtools/0.1.19/bin/samtools view -@ 32 -S -b -o unsorted.bam ros.sam
#wait 
 /usr/local/Modules/modulefiles/tools/samtools/0.1.19/bin/samtools sort -@ 32  unsorted.bam sorted
#
/usr/local/Modules/modulefiles/tools/samtools/0.1.19/bin/samtools index sorted*
# deep v to call 
/opt/deepvariant/bin/run_deepvariant       --model_type=WGS       --ref=cb_Illumina_pilon_iter4.fasta     --reads=/storage/home/users/pjt6/ros/RNAseq/sorted.bam   --output_vcf=/storage/home/users/pjt6/ros/RNAseq/cb.genomics.vcf      --output_gvcf=/storage/home/users/pjt6/ros/RNAseq/cb.genomics.g.vcf.gz       --num_shards=36

pigz R2.fq
pigz R1.fq