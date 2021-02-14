#!/bin/bash -l
#SBATCH -J funan   #jobname
#SBATCH --partition=long
#SBATCH --cpus-per-task=30
#SBATCH --mem=60GB
cd /home/pthorpe/scratch/cb/final
conda activate funannotate

###########################
# variables
genome="Crenichthys_baileyi.v1.0.softmasked.fasta"
threads=30
left="R1.fq.gz"
right="R2.fq.gz"
name="CRENBAI"
species="Crenichthys_baileyi" # two words
strain="V.1.0" # ,ust put a strain
out_folder="cb_funannotate"
max_intron_len=15000
RM_lib="consensi.fa.classified"


################################
#GPAL_newton_softmasked

# 1) # rename the scafold and sort by length
#funannotate clean -i ${genome} --minlen 1000 -o ${genome}.cleaned.fa  

# 2) sort by length
#funannotate sort -i${genome}.cleaned.fa -b scaffold -o ${genome}.cleaned.sorted.fa  

# 3) mask
#funannotate mask --repeatmodeler_lib consensi.fa.censor -i Crenichthys_baileyi.v1.0.softmasked.fasta --cpus 30 -o Crenichthys_baileyi.v1.0.softmasked_tantan.fasta

funannotate mask -m repeatmodeler -i Crenichthys_baileyi.v1.0.softmasked_tantan.fasta --cpus 30 -o Crenichthys_baileyi.v1.0.softmasked_tantan_RM.fasta
