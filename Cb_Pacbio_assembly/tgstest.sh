#!/bin/bash -l
#SBATCH -J tgstest   #jobname
#SBATCH --partition=long
#SBATCH --cpus-per-task=48
#SBATCH --mem=180GB

conda activate TGSgapcloser
cd /home/pthorpe/scratch/cb
tgsgapcloser --tgstype pb --racon /mnt/shared/scratch/pthorpe/apps/conda/envs/TGSgapcloser/bin/racon --scaff scaffolds_gapfilled_FINAL.fasta --reads /home/pthorpe/scratch/cb/raw_reads.fa --output tgs --thread 48
