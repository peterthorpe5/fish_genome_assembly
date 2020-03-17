#!/bin/bash
#$ -cwd

cd /storage/home/users/pjt6/fish_genomes
threads=1



cd /storage/home/users/pjt6/fish_genomes/xr
##cp /storage/home/users/pjt6/fish_genomes/raw_data/Xr_S_M_M6_2_DNA/*_1.fq.gz ./
#cp /storage/home/users/pjt6/fish_genomes/raw_data/Xr_S_M_M6_2_DNA/*_2.fq.gz ./
#pigz -d *.gz


#bwa index  scaffolds.fasta
#bwa mem -t $THREADS /storage/home/users/pjt6/fish_genomes/xr/xr Xr_S_M_M6_2_DNA_UKDSW01701_HGV7FDSXX_L2_1.fq Xr_S_M_M6_2_DNA_UKDSW01701_HGV7FDSXX_L2_2.fq > xr.sam

#bwa index -p xr scaffolds.fasta
#bwa mem -t $THREADS scaffolds.fasta Xr_S_M_M6_2_DNA_UKDSW01701_HGV7FDSXX_L2_1.fq Xr_S_M_M6_2_DNA_UKDSW01701_HGV7FDSXX_L2_2.fq > xr_scaff.sam

#/storage/home/users/pjt6/shelf_apps/apps/bwa-mem2-2.0pre2_x64-linux/bwa-mem2 index -p xr scaffolds.fasta

/storage/home/users/pjt6/shelf_apps/apps/bwa-mem2-2.0pre2_x64-linux/bwa-mem2 mem -t 16 xr  Xr_S_M_M6_2_DNA_UKDSW01701_HGV7FDSXX_L2_1.fq Xr_S_M_M6_2_DNA_UKDSW01701_HGV7FDSXX_L2_2.fq > xr_scaff.sam
