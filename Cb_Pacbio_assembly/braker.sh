#!/bin/bash -l
#SBATCH -J cbBraker   #jobname
#SBATCH --partition=long
#SBATCH --cpus-per-task=30
#SBATCH --mem=160GB

cd /home/pthorpe/scratch/cb/final


#export PATH=/mnt/shared/scratch/pthorpe/apps/conda/envs/funannotate/bin/:$PATH

conda activate braker2

#export PATH=/mnt/shared/scratch/pthorpe/apps/conda/envs/samtools/lib/:$PATH


#############################################################
# 1) just braker nothing extra

# make a back up of the default ctf file
#--extrinsicCfgFile=/mnt/shared/scratch/pthorpe/apps/conda/envs/braker2/bin/cfg/rnaseq.cfg
#cp /mnt/shared/scratch/pthorpe/apps/conda/envs/braker2/bin/cfg/rnaseq.cfg /mnt/shared/scratch/pthorpe/apps/conda/envs/braker2/bin/cfg/rnaseq.cfg.bk


#cp ex1.cfg /mnt/shared/scratch/pthorpe/apps/conda/envs/braker2/bin/cfg/rnaseq.cfg
#cp ex1_utr.cfg /mnt/shared/scratch/pthorpe/apps/conda/envs/braker2/bin/cfg/rnaseq_utr.cfg


echo "2) running test on comp braker and utr nothing extra"
cmd='/home/pthorpe/apps/BRAKER/scripts/braker.pl 
--genome=Crenichthys_baileyi.v1.0.softmasked_tantan.fasta
--overwrite
--skip_fixing_broken_genes
--species Crenichthys_baileyi4
--PYTHON3_PATH=/mnt/shared/scratch/pthorpe/apps/conda/envs/braker2/bin/
--workingdir=/home/pthorpe/scratch/cb/final/braker2/
--SAMTOOLS_PATH=/mnt/shared/scratch/pthorpe/apps/conda/envs/braker2/bin/
--bam=cbAligned.sortedByCoord.out.bam 
--cores 30 --gff3 --rounds 5 
--filterOutShort 
--utr on
--augustus_args="--protein=on --start=on --stop=on --cds=on --introns=on  --stopCodonExcludedFromCDS=False --genemodel=complete " 
--softmasking '
echo ${cmd}
eval ${cmd}
#--genemark_hintsfile /mnt/shared/scratch/pthorpe/private/cb/final/genemark_hintsfile.gff
#--geneMarkGtf genemark.gtf

#--geneMarkGtf /home/pthorpe/scratch/cb/final/genemark.gtf
#--hints /home/pthorpe/scratch/cb/final/braker/hintsfile.gff
#--genemark_hintsfile /mnt/shared/scratch/pthorpe/private/cb/final/genemark_hintsfile.gff
genemark_hintsfile.gff
