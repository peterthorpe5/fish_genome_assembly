#!/bin/bash
#$ -V ## pass all environment variables to the job, VERY IMPORTANT
#$ -N MAIN_wtdbg ## job name
#$ -S /bin/bash ## shell where it will run this job
####$ -j y ## join error output to normal output
#$ -cwd ## Execute the job from the current working directory

cd /storage/home/users/pjt6/pb_fish

module load oraclejava/jdk1.8.0_74
#default

filenames=*.fastq
#
for f in ${filenames}
do
    /storage/home/users/pjt6/pb_fish/wtdbg2/wtdbg2 -t 16 -x rsII -g 1.2g -L 5000 -p 19 -i ${f} -fo ${f}_MIN5000
    /storage/home/users/pjt6/pb_fish/wtdbg2/wtpoa-cns -t 16  -i ${f}_MIN5000.ctg.lay.gz -fo ${f}_MIN5000.ctg.p19_L5000.lay.fa

    /storage/home/users/pjt6/pb_fish/wtdbg2/wtdbg2 -t 16 -x rsII -g 1.2g -i ${f} -fo ${f}_default
    /storage/home/users/pjt6/pb_fish/wtdbg2/wtpoa-cns -t 16  -i ${f}_default.ctg.lay.gz -fo ${f}_default.lay.fa

    /storage/home/users/pjt6/pb_fish/wtdbg2/wtdbg2 -t 16 -x rsII -g 1.2g -L 5000 -p 20 -i ${f} -fo ${f}_MIN5000
    /storage/home/users/pjt6/pb_fish/wtdbg2/wtpoa-cns -t 16  -i ${f}_MIN5000.ctg.lay.gz -fo ${f}_MIN5000.ctg.p20_L5000.lay.fa
     /storage/home/users/pjt6/pb_fish/wtdbg2/wtdbg2 -t 16 -x rsII -g 1.2g -L 5000 -i ${f} -fo ${f}_MIN5000
    /storage/home/users/pjt6/pb_fish/wtdbg2/wtpoa-cns -t 16  -i ${f}_MIN5000.ctg.lay.gz -fo ${f}_MIN5000.ctg.pdefault_L5000.lay.fa
    /storage/home/users/pjt6/pb_fish/wtdbg2/wtdbg2 -t 16 -x rsII -g 1.2g -L 4000 -p 19 -i ${f} -fo ${f}_MIN4000
    /storage/home/users/pjt6/pb_fish/wtdbg2/wtpoa-cns -t 16  -i ${f}_MIN4000.ctg.lay.gz -fo ${f}_MIN4000.ctg.p19_L4000.lay.fa
    #
    /storage/home/users/pjt6/pb_fish/wtdbg2/wtdbg2 -t 16 -x rsII -g 1.2g -L 5000 -p 19 -e2 -i ${f} -fo ${f}_MIN5000
    /storage/home/users/pjt6/pb_fish/wtdbg2/wtpoa-cns -t 16  -i ${f}_MIN5000.ctg.lay.gz -fo ${f}_MIN5000.ctg.p19_e2_L5000.lay.fa
    /storage/home/users/pjt6/pb_fish/wtdbg2/wtdbg2 -t 16 -x rsII -g 1.2g -L 5000 -p 20 -e2  -i ${f} -fo ${f}_MIN5000
    /storage/home/users/pjt6/pb_fish/wtdbg2/wtpoa-cns -t 16  -i ${f}_MIN5000.ctg.lay.gz -fo ${f}_MIN5000.ctg.p20_e2L5000.lay.fa
     /storage/home/users/pjt6/pb_fish/wtdbg2/wtdbg2 -t 16 -x rsII -g 1.2g -L 5000  -e2 -i ${f} -fo ${f}_MIN5000
    /storage/home/users/pjt6/pb_fish/wtdbg2/wtpoa-cns -t 16  -i ${f}_MIN5000.ctg.lay.gz -fo ${f}_MIN5000.ctg.pdefault_e2_L5000.lay.fa
    /storage/home/users/pjt6/pb_fish/wtdbg2/wtdbg2 -t 16 -x rsII -g 1.2g -L 4000  -e2 -p 19 -i ${f} -fo ${f}_MIN4000
    /storage/home/users/pjt6/pb_fish/wtdbg2/wtpoa-cns -t 16  -i ${f}_MIN4000.ctg.lay.gz -fo ${f}_MIN4000.ctg.p19_e2_L4000.lay.fa
    #
    /storage/home/users/pjt6/pb_fish/wtdbg2/wtdbg2 -t 16 -x rsII -g 1.2g -L 5000 -p 19 -e2 -AS2 -i ${f} -fo ${f}_MIN5000
    /storage/home/users/pjt6/pb_fish/wtdbg2/wtpoa-cns -t 16  -i ${f}_MIN5000.ctg.lay.gz -fo ${f}_MIN5000.ctg.p19_e2-AS2_L5000.lay.fa
    /storage/home/users/pjt6/pb_fish/wtdbg2/wtdbg2 -t 16 -x rsII -g 1.2g -L 5000 -p 20 -e2 -AS2 -i ${f} -fo ${f}_MIN5000
    /storage/home/users/pjt6/pb_fish/wtdbg2/wtpoa-cns -t 16  -i ${f}_MIN5000.ctg.lay.gz -fo ${f}_MIN5000.ctg.p20_e2-AS2L5000.lay.fa
     /storage/home/users/pjt6/pb_fish/wtdbg2/wtdbg2 -t 16 -x rsII -g 1.2g -L 5000  -e2 -AS2 -i ${f} -fo ${f}_MIN5000
    /storage/home/users/pjt6/pb_fish/wtdbg2/wtpoa-cns -t 16  -i ${f}_MIN5000.ctg.lay.gz -fo ${f}_MIN5000.ctg.pdefault_e2-AS2_L5000.lay.fa
    /storage/home/users/pjt6/pb_fish/wtdbg2/wtdbg2 -t 16 -x rsII -g 1.2g -L 4000  -e2 -AS2 -p 19 -i ${f} -fo ${f}_MIN4000
    /storage/home/users/pjt6/pb_fish/wtdbg2/wtpoa-cns -t 16  -i ${f}_MIN4000.ctg.lay.gz -fo ${f}_MIN4000.ctg.p19_e2-AS2_L4000.lay.fa
    
    /storage/home/users/pjt6/pb_fish/wtdbg2/wtdbg2 -t 16 -x rsII -g 1.2g -L 1000  -e2 -AS2 -p 19 -i ${f} -fo ${f}_MIN1000
    /storage/home/users/pjt6/pb_fish/wtdbg2/wtpoa-cns -t 16  -i ${f}_MIN1000.ctg.lay.gz -fo ${f}_MIN1000.ctg.p19_e2-AS2_L1000.lay.fa
done



conda activate python36

export AUGUSTUS_CONFIG_PATH=~/shelf_apps/apps/augustus-3.2.1/config/


# need to make a symbolic link to LINAGE
mkdir LINEAGE
wait
#~ NOTE the nematode dataset was downloaded and used in place og Metazo models. 
ln -s ~/shelf_apps/apps/BUSCO_v1.1b1/eukaryota ./LINEAGE/
wait

# hah! it's not...CB: Crenichthys baileyi - Is   cb:   girardinychthyes_multiradiatus   ? or an I mental?
# I got my wires crossed … its ok. Just be aware of this. I have train Augustus on the Cb genome and called the models Girardinychthyes multiradiatus 😊 -  this is to save time with BUSCO later. 
filenames=*.fa

for f in ${filenames}
do
    python ~/shelf_apps/apps/BUSCO_v1.1b1/BUSCO_v1.1b1.py -in ${f} -l ./LINEAGE/eukaryota -o ${f}_BUSCO  -f -Z 827000000 --cpu 16 --species girardinychthyes_multiradiatus
done

