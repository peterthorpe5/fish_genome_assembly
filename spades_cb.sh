#!/bin/bash -l
#SBATCH -J SPADES_cb   #jobname
#SBATCH -N 1     #node
#SBATCH --tasks-per-node=64
#SBATCH -p bigmem
#SBATCH --nodelist=kennedy150
#SBATCH --mem=1450GB

cd /gpfs1/home/pjt6/scratch

# conda to activate the software
echo $PATH
#conda activate spades

echo $PATH
#cat /home/pjt6/scratch/Cb_M1G/Cb_M1G_UKDSW01698_HGVFGDSXX_L1_1.fq.gz \
#/home/pjt6/scratch/Cb_M1G.2/Cb_M1G_EDSW190023076-2a_HVTCJDSXX_L2_1.fq.gz \
#/home/pjt6/scratch/Cb_M1G.2/Cb_M1G_EDSW190023076-2a_HMGW3DSXX_L4_1.fq.gz > R1.fq.gz
#
#cat /home/pjt6/scratch/Cb_M1G/Cb_M1G_UKDSW01698_HGVFGDSXX_L1_2.fq.gz \
#/home/pjt6/scratch/Cb_M1G.2/Cb_M1G_EDSW190023076-2a_HVTCJDSXX_L2_2.fq.gz \
#/home/pjt6/scratch/Cb_M1G.2/Cb_M1G_EDSW190023076-2a_HMGW3DSXX_L4_2.fq.gz > R2.fq.gz

# run the assembly with 1.45 TB RAM. 64 threads
spades.py -o cb_clc --only-assembler \
-1 /gpfs1/scratch/bioinf/pjt6/cb/corrected/R1.fq.00.0_0.cor.fastq.gz \
-2 /gpfs1/scratch/bioinf/pjt6/cb/corrected/R2.fq.00.0_0.cor.fastq.gz \
-k 55,77,99,117 \
--trusted-contigs /gpfs1/scratch/bioinf/pjt6/clc_assemblyv1/cb.clc.EC.fa -t 64 -m 1450 

conda deactivate 
echo $PATH
conda activate python27

echo $PATH
