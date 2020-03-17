#!/bin/bash
#$ -cwd
cd /shelf/apps/User_name/newton/stricter_scaff_polish/

conda activate python36

cd /storage/home/users/pjt6/fish_genomes/
cd /storage/home/users/pjt6/fish_genomes/cb/



export AUGUSTUS_CONFIG_PATH=~/shelf_apps/apps/augustus-3.2.1/config/

cd /shelf/apps/User_name/newton/stricter_scaff_polish
# need to make a symbolic link to LINAGE
mkdir LINEAGE
wait
#~ NOTE the nematode dataset was downloaded and used in place og Metazo models. 
ln -s ~/shelf_apps/apps/BUSCO_v1.1b1/eukaryota ./LINEAGE/
wait


filenames=*.fasta
#
for f in ${filenames}
do
    python ~/shelf_apps/apps/BUSCO_v1.1b1/BUSCO_v1.1b1.py --long -in ${f} -l ./LINEAGE/eukaryota -o ${f}_BUSCO  -f \
    -Z 827000000 --cpu 16 
done


cd /storage/home/users/pjt6/fish_genomes/xc/



export AUGUSTUS_CONFIG_PATH=~/shelf_apps/apps/augustus-3.2.1/config/

cd /shelf/apps/User_name/newton/stricter_scaff_polish
# need to make a symbolic link to LINAGE
mkdir LINEAGE
wait
#~ NOTE the nematode dataset was downloaded and used in place og Metazo models. 
ln -s ~/shelf_apps/apps/BUSCO_v1.1b1/eukaryota ./LINEAGE/
wait


filenames=*.fasta
#
for f in ${filenames}
do
    python ~/shelf_apps/apps/BUSCO_v1.1b1/BUSCO_v1.1b1.py --long -in ${f} -l ./LINEAGE/eukaryota -o ${f}_BUSCO  -f \
    -Z 827000000 --cpu 16 
done