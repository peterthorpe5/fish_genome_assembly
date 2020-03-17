#!/bin/bash
#$ -cwd

#cd /storage/home/users/pjt6/fish_genomes/

#python ~/public_scripts/split_up_fasta_file_into_N_files/split_up_fasta_file.py -n 100 -i scaffolds.fasta

cd /storage/home/users/pjt6/fish_genomes/ga/split_fasta_files

fasta=Ga_clc_Spade_v1._10?.fasta

for f in ${fasta}
do
    blastn -task megablast -query ${f} -db nt -outfmt '6 qseqid staxids bitscore std scomnames sscinames sblastnames sskingdoms stitle' -evalue 1e-20 -out ${f}_blast -num_threads 4
    CMD="blobtools create -i ${f}  --type spades -t ${f}_blast -o ga_V1.blobplots_${f} --nodes /shelf/public/blastntnr/blastDatabases/nodes.dmp --names /shelf/public/blastntnr/blastDatabases/names.dmp"
    echo ${CMD}
    eval ${CMD}
    mkdir ${f}_allfinal.fa.blobplots
    cp ga_V1.blobplots_${f}.blobDB.json ./${f}_allfinal.fa.blobplots
    echo "blobtools view for ${f}"
    blobtools view -i  ga_V1.blobplots_${f}.blobDB.json -o ${f}_allfinal.fa.blobplots/
    echo "blobtools plot for ${f}"

    blobtools plot -s  -i ga_V1.blobplots_${f}.blobDB.json -o ${f}_allfinal.fa.blobplots/
    pigz --best ${f}_blast
    pigz --best ${f}
    
    cd ${f}_allfinal.fa.blobplots
    cat *.blobDB.table.txt | grep "Streptophyta" | cut -f1 > Streptophyta.names
    cat *.blobDB.table.txt | grep "Arthropoda" | cut -f1 > Arthropoda.names
    cat *.blobDB.table.txt | grep "Ascomycota" | cut -f1 > Ascomycota.names
    #cat *.blobDB.table.txt | grep "Chordata" | cut -f1 > Chordata.names
    #cat *.blobDB.table.txt | grep "Nematoda" | cut -f1 > Nematoda.names
    cat *.blobDB.table.txt | grep "Basidiomycota" | cut -f1 > Basidiomycota.names
    cat *.blobDB.table.txt | grep "Proteobacteria" | cut -f1 > Proteobacteria.names
    cat *.blobDB.table.txt | grep "Bacteria-undef" | cut -f1 > Bacteria-undef.names
    cat *.blobDB.table.txt | grep "Viruses-undef" | cut -f1 > Viruses-undef.names
    #cat *.blobDB.table.txt | grep "Cnidaria" | cut -f1 > Cnidaria.names
    cat *.blobDB.table.txt | grep "Actinobacteria" | cut -f1 > Actinobacteria.names
    cat *.blobDB.table.txt | grep "Mucoromycota" | cut -f1 > Mucoromycota.names
    cat *.blobDB.table.txt | grep "Euryarchaeota" | cut -f1 > Euryarchaeota.names 
    cat *.blobDB.table.txt | awk '$5 < 5' | grep 'no-hit' | sort -k4 -rn | cut -f1 > low_cov_5.LOOKATME
    cat *.names >  bad_contigs.out
    cd /storage/home/users/pjt6/fish_genomes/ga/split_fasta_files
done
    
    #python ~/public_scripts/get_sequences_i_want_from_fasta_command_line_not_wanted_file.py scaffold.fasta ./${f}_allfinal.fa.blobplots/bad_contigs.out 10 ga_contanim_filtered_v1.fasta


