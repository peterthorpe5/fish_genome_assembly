#!/bin/bash -l
#SBATCH -J CL_spades   #jobname
#SBATCH --partition=long
#SBATCH --cpus-per-task=24
#SBATCH -p himem
#SBATCH --mem=350GB

cd /mnt/shared/scratch/pthorpe/private/assemblies/CL/
conda activate spades
# spades-3.14.1

/mnt/shared/scratch/pthorpe/private/assemblies/spades.py --checkpoints  last -k 35,55,77,97,127 -o fish -s crap1.fq.gz -1 R1.fq.gz -2 R2.fq.gz -t 24 -m 345

