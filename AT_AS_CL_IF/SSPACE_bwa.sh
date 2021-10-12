#!/bin/bash -l
#SBATCH -J CL   #jobname
#SBATCH --partition=long
#SBATCH --cpus-per-task=32
#SBATCH --mem=170GB
conda activate sspace

cd /mnt/shared/scratch/pthorpe/private/assemblies

output=CL_SS1

mkdir ${output}.evidence
mkdir ${output}.evidence/intermediate_results/

perl /home/pthorpe/apps/SSPACE-STANDARD-3.0_linux-x86_64/SSPACE_Standard_v3.0.pl \
 -l libraries_bwa.txt -s /mnt/shared/scratch/pthorpe/private/assemblies/CL/scaffolds.fasta \
 -k 5 -a 0.7 -x 0 -m 30 -o 20 -T 32 -z 1000 -b ${output}.fasta
 
 