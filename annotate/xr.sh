#!/bin/bash -l
#SBATCH -J Cb_fun   #jobname
#SBATCH -N 1     #node
#SBATCH --ntasks-per-node=30
#SBATCH --threads-per-core=2
#SBATCH -p bigmem
#SBATCH --mem=150GB


cd /home/pjt6/scratch/funanotate_stuff

conda activate funannotate

###########################
# variables
genome="Xr_V1.0.softmasked.fasta"
threads=30

#Gm = Girardinychthyes multiradiatus
#Xc = Xenoophorus captivus
#Ga = Goodea atripinis
#Xr= Xenotaenia resolanae


species="Xenotaenia_resolanae" # two words
#strain="Girmult" # ,ust put a strain
out_folder="xr"
name="XENORESO"
max_intron_len=15000

# Setting for the new UTF-8 terminal support in Lion
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

#cp /home/pjt6/Desktop/newton_final_masked_mito/braker_20_rounds/augustus.hints.gff3 ./
# 5) predict genes - it will know where to look for the out files form the other runs. --organism other (for non fungal)
predict="funannotate predict -i ${genome} -o ${out_folder} \
    --species  ${species} 
    --cpus ${threads} --max_intronlen ${max_intron_len} 
--busco_db  eukaryota_odb9
    --optimize_augustus
    --database /home/pjt6/scratch/funanotate_stuff/databases/ 
    --name ${name} --ploidy 2 --SeqCenter  DUNDEE --organism other
	--min_training_models 180
"
echo ${predict}  
eval ${predict}
