#!/bin/bash -l
#SBATCH -J GA_fun   #jobname
#SBATCH -N 1     #node
#SBATCH --ntasks-per-node=48
#SBATCH --threads-per-core=2
#SBATCH -p bigmem
#SBATCH --mem=150GB


cd /home/pjt6/scratch/funanotate_stuff

conda activate funannotate

###########################
# variables
genome="Ga_V1.0.softmasked.fasta"
threads=48

#Gm = Girardinychthyes multiradiatus
#Xc = Xenoophorus captivus
#Ga = Goodea atripinis
#Xr= Xenotaenia resolanae


species="Goodea_atripinis" # two words
#strain="Ga" # ,ust put a strain
out_folder="Ga"
name="GOODATRI"
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
"
echo ${predict}  
eval ${predict}
