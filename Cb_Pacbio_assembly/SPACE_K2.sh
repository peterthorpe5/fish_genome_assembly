#!/bin/bash -l
#SBATCH -J cb_SSPACE   #jobname
#SBATCH --partition=long
#SBATCH --cpus-per-task=48
#SBATCH -p himem
#SBATCH --mem=260GB

# this has the perl with the dependancies
conda activate bioperl

cd /home/pthorpe/scratch/cb

###################################################################################
#round1

perl /home/pthorpe/apps/SSPACE-STANDARD-3.0_linux-x86_64//SSPACE-LongRead.pl -g 500 -l 10 -o 1000  -c curated.fasta -p /home/pthorpe/scratch/cb/raw_reads.fa -b sspace_long_read_A80_k_minlink10_g500_o100 -t 48   -k 1

cd /home/pthorpe/scratch/cb/sspace_long_read_A80_k_minlink10_g500_o100/
/home/pthorpe/apps/gapFinisher/gapFinisher -i /home/pthorpe/scratch/cb/sspace_long_read_A80_k_minlink10_g500_o100/ -l /home/pthorpe/scratch/cb/raw_reads.fa -m /home/pthorpe/apps/mcr/v717/ -t 1


###################################################################################
#round2
perl /home/pthorpe/apps/SSPACE-STANDARD-3.0_linux-x86_64//SSPACE-LongRead.pl -g 500 -l 5 -o 1000  -c scaffolds_gapfilled_FINAL.fasta -p /home/pthorpe/scratch/cb/raw_reads.fa -b sspace_long_read_A80_k_minlink10_g500_o100 -t 48   -k 1

cd /home/pthorpe/scratch/cb/sspace_long_read_A80_k_minlink10_g500_o100//sspace_long_read_A80_k_minlink10_g500_o100
/home/pthorpe/apps/gapFinisher/gapFinisher -i /home/pthorpe/scratch/cb/sspace_long_read_A80_k_minlink10_g500_o100//sspace_long_read_A80_k_minlink10_g500_o100 -l /home/pthorpe/scratch/cb/raw_reads.fa -m /home/pthorpe/apps/mcr/v717/ -t 1

cd /home/pthorpe/scratch/cb/sspace_long_read_A80_k_minlink10_g500_o100//sspace_long_read_A80_k_minlink10_g500_o100

###################################################################################
#round3

perl /home/pthorpe/apps/SSPACE-STANDARD-3.0_linux-x86_64//SSPACE-LongRead.pl -g 500 -l 5 -o 1000  -c scaffolds_gapfilled_FINAL.fasta -p \
/home/pthorpe/scratch/cb/raw_reads.fa -b sspace_long_read_A80_k_minlink10_g500_o100 -t 48   -k 1

cd ./sspace_long_read_A80_k_minlink10_g500_o100
/home/pthorpe/apps/gapFinisher/gapFinisher -i /home/pthorpe/scratch/cb/sspace_long_read_A80_k_minlink10_g500_o100//sspace_long_read_A80_k_minlink10_g500_o100/sspace_long_read_A80_k_minlink10_g500_o100 -l /home/pthorpe/scratch/cb/raw_reads.fa -m /home/pthorpe/apps/MCR/v717/ -t 1

###################################################################################
#round4

perl /home/pthorpe/apps/SSPACE-STANDARD-3.0_linux-x86_64//SSPACE-LongRead.pl -g 500 -l 3 -o 1000  -c scaffolds_gapfilled_FINAL.fasta -p \
/home/pthorpe/scratch/cb/raw_reads.fa -b sspace_long_read_A80_k_minlink10_g500_o100 -t 48   -k 1

cd ./sspace_long_read_A80_k_minlink10_g500_o100
/home/pthorpe/apps/gapFinisher/gapFinisher -i /home/pthorpe/scratch/cb/sspace_long_read_A80_k_minlink10_g500_o100//sspace_long_read_A80_k_minlink10_g500_o100/sspace_long_read_A80_k_minlink10_g500_o100/sspace_long_read_A80_k_minlink10_g500_o100 -l /home/pthorpe/scratch/cb/raw_reads.fa -m /home/pthorpe/apps/MCR/v717/ -t 1


wait
#conda activate purge_haplotigs

cd /home/pthorpe/scratch/cb/sspace_long_read_A80_k_minlink10_g500_o100//sspace_long_read_A80_k_minlink10_g500_o100/sspace_long_read_A80_k_minlink10_g500_o100

minialign -t16 -xont scaffolds_gapfilled_FINAL.fasta /storage/home/users/pjt6/shelf_apps/newton/reads/newton_using_EC_reads_EC85.correctedReads.fasta.gz > temp.sam
wait 
samtools view -@ 16 -S -b -o unsorted.bam temp.sam
wait 
samtools sort -@ 16 -o sorted.bam unsorted.bam 

samtools index sorted*bam

#rm temp.sam unsorted.bam

wait 
purge_haplotigs readhist -b sorted*bam -t 8 -g scaffolds_gapfilled_FINAL.fasta
#
#
purge_haplotigs  contigcov  -i sorted*bam.gencov -o coverage_stats.csv  -l 3  -m 27  -h 130
#
##
#
purge_haplotigs purge  -g scaffolds_gapfilled_FINAL.fasta  -c coverage_stats.csv  -b sorted*bam  -t 48   -a 80

perl ~/scaffold_stats.pl -f curated.fasta > curated.stat
