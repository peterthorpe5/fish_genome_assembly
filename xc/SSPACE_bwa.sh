#!/bin/bash
#$ -cwd

cd /storage/home/users/pjt6/fish_genomes/xc
perl /storage/home/users/pjt6/shelf_apps/apps/SSPACE-STANDARD-3.0_linux-x86_64/SSPACE_Standard_v3.0.pl \
 -l libraries_bwa.txt -s /storage/home/users/pjt6/fish_genomes/xc/xc_CLC_sp_scaff_cont_clean.fasta \
 -k 5 -a 0.7 -x 0 -m 30 -o 20 -T 16 -z 1500 -b xc_CLC_sp_scaff_cont_clean_SS1.fasta
 
 