#!/bin/bash
#$ -cwd

cd /storage/home/users/pjt6/fish_genomes
threads=16



#########################
cd /storage/home/users/pjt6/fish_genomes/cb/
pigz -d R2.fq.gz

#/storage/home/users/pjt6/shelf_apps/apps/bwa-mem2-2.0pre2_x64-linux/bwa-mem2 index scaffolds.fasta

/storage/home/users/pjt6/shelf_apps/apps/bwa-mem2-2.0pre2_x64-linux/bwa-mem2 mem -t 16 scaffolds.fasta  R1.fq R2.fq > cb.sam

