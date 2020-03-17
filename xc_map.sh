#!/bin/bash
#$ -cwd

cd /storage/home/users/pjt6/fish_genomes
threads=16



cd /storage/home/users/pjt6/fish_genomes/xc

#cp /storage/home/users/pjt6/fish_genomes/raw_data/Xc_S_M_M6_3_DNA/*_1.fq.gz ./
#cp  /storage/home/users/pjt6/fish_genomes/raw_data/Xc_S_M_M6_3_DNA/*_2.fq.gz ./
#pigz -d *.gz


/storage/home/users/pjt6/shelf_apps/apps/bwa-mem2-2.0pre2_x64-linux/bwa-mem2 index scaffolds.fasta

/storage/home/users/pjt6/shelf_apps/apps/bwa-mem2-2.0pre2_x64-linux/bwa-mem2 mem -t 16 scaffolds.fasta *_1.fq *_2.fq > xc.sam

