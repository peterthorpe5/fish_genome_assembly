#!/bin/bash
#$ -cwd
cd /storage/home/users/pjt6/pb_fish/RNAseq


conda activate trinity


 Trinity --genome_guided_bam cbAligned.sortedByCoord.out.bam \
         --genome_guided_max_intron 15000 \
         --CPU 40 --max_memory 300G --full_cleanup --output Gp_genome_gui_Trinity --genome_guided_min_coverage 4
         
 