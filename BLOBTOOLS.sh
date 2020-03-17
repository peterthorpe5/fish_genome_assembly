#!/bin/bash
#$ -cwd
cd /storage/home/users/pjt6/fish_genomes/
cd /storage/home/users/pjt6/fish_genomes/cb/


blastn -task megablast -query *.fasta -db nt -outfmt '6 qseqid staxids bitscore std scomnames sscinames sblastnames sskingdoms stitle' -evalue 1e-20 -out n.clc.allfinal.out -num_threads 16


cd /storage/home/users/pjt6/fish_genomes/xc
blastn -task megablast -query *.fasta -db nt -outfmt '6 qseqid staxids bitscore std scomnames sscinames sblastnames sskingdoms stitle' -evalue 1e-20 -out n.clc.allfinal.out -num_threads 16

blobtools create -i newt_correc_corre.ctg.L4000_p19_lay.fa  -s temp.sam -t n.clc.allfinal.out -o newt_correc_corre.ctg.l5000_p_default_lay.fa.blobplots
 
 mkdir allfinal.fa.blobplots
 cp newt_correc_corre.ctg.l5000_p_default_lay.fa.blobplots.blobDB.json ./allfinal.fa.blobplots
 
blobtools view -i  newt_correc_corre.ctg.l5000_p_default_lay.fa.blobplots.blobDB.json -o allfinal.fa.blobplots/
 
blobtools blobplot -i newt_correc_corre.ctg.l5000_p_default_lay.fa.blobplots.blobDB.json -o allfinal.fa.blobplots/ 

#rm temp.sam

cd allfinal.fa.blobplots
cat *.blobDB.table.txt | grep "Streptophyta" | cut -f1 > Streptophyta.names
#cat *.blobDB.table.txt | grep "Arthropoda" | cut -f1 > Arthropoda.names
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

cd ../

python /shelf/apps/User_name/apps/public_scripts-master/get_sequences_i_want_from_fasta_command_line_not_wanted_file.py newt_correc_corre.ctg.L4000_p19_lay.fa ./allfinal.fa.blobplots/bad_contigs.out 10 newt_correc_corre.ctg.L4000_p19.contim_filtered_final.fasta
rm temp.sam

cp newt_correc_corre.ctg.L4000_p19.contim_filtered_final.fasta contigs.fasta

python /shelf/apps/User_name/apps/finishingTool/finisherSC.py -par 8 /storage/home/users/User_name/shelf_apps/newton/newton_wtdgb/L4000/ /shelf/apps/User_name/conda/envs/python27/bin/


