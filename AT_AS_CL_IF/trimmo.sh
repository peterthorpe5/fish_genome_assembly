#!/bin/bash
#$ -cwd
java -jar /shelf/training/Trimmomatic-0.38/trimmomatic-0.38.jar PE -summary trim_summary.txt  \
-threads 16 -phred33 r1.fq.gz r2.fq.gz \
R1.fq.gz crap1.fq.gz R2.fq.gz \
crap2.fq.gz ILLUMINACLIP:/shelf/training/Trimmomatic-0.38/adapters/TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:57
