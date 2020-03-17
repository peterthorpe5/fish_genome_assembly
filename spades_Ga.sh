#!/bin/bash -l
#SBATCH -J SPADES_ga   #jobname
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

# run the assembly with 1.45 TB RAM. 64 threads
spades.py -o Ga_clc --only-assembler \
-1 /gpfs1/scratch/bioinf/pjt6/Ga/corrected/Ga_S_M_M6_2_DNA_UKDSW01699_HGV7FDSXX_L2_1.fq.00.0_0.cor.fastq.gz \
-2 /gpfs1/scratch/bioinf/pjt6/Ga/corrected/Ga_S_M_M6_2_DNA_UKDSW01699_HGV7FDSXX_L2_2.fq.00.0_0.cor.fastq.gz \
--trusted-contigs /gpfs1/scratch/bioinf/pjt6/clc_assemblyv1/ga.clc.Raw.fa -k 55,77,99,117 -t 64 -m 1450 


conda deactivate 
echo $PATH
conda activate python27

echo $PATH
