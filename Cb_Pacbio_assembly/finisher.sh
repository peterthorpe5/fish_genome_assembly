#$ -cwd
cd /storage/home/users/pjt6/pb_fish/contigs/
# purger, purged, output all data, blobtools

#python ~/misc_python/convert_file_format/convert_fq_to_fa.py -i raw_reads.fastq -o raw_reads.fasta

conda activate python27

######################################################
# 1) finisher

python /shelf/apps/pjt6/apps/finishingTool/finisherSC.py -par 40 /storage/home/users/pjt6/pb_fish/contigs/ /shelf/apps/pjt6/conda/envs/python27/bin/

######################################################################
# 2 ) purge haplotypes A80 strict
conda activate purge_haplotigs

minialign -t16 -xont improved3.fasta /storage/home/users/pjt6/pb_fish/contigs/raw_reads.fasta > temp.sam
wait 
samtools view -@ 32 -S -b -o unsorted.bam temp.sam
wait 
samtools sort -@ 32 -o sorted unsorted.bam 

samtools index sorted*

wait 
purge_haplotigs readhist -b sorted.bam -t 32 -g improved3.fasta
#
#
purge_haplotigs  contigcov  -i sorted.bam.gencov -o coverage_stats.csv  -l 3  -m 27  -h 130
#
##
#
purge_haplotigs purge  -g improved3.fasta  -c coverage_stats.csv  -b sorted.bam  -t 32 -a 80

#################
# 3 ) run busco
export AUGUSTUS_CONFIG_PATH=~/shelf_apps/apps/augustus-3.2.1/config/

# need to make a symbolic link to LINAGE
mkdir LINEAGE
wait
#~ NOTE the nematode dataset was downloaded and used in place og Metazo models. 
ln -s ~/shelf_apps/apps/BUSCO_v1.1b1/eukaryota ./LINEAGE/
wait


filenames=curated.fa*
#
for f in ${filenames}
do
    python ~/shelf_apps/apps/BUSCO_v1.1b1/BUSCO_v1.1b1.py -in ${f} -l ./LINEAGE/eukaryota -o ${f}_BUSCO  -f -Z 827000000 --cpu 32 --species girardinychthyes_multiradiatus
done
##############################
# 4) run blobtools

conda activate python27


/shelf/apps/pjt6/conda/envs/python27/bin/minialign -t40 -xont curated.fasta raw_reads.fasta > temp.sam


blastn -task megablast -query curated.fasta -db nt -outfmt '6 qseqid staxids bitscore std scomnames sscinames sblastnames sskingdoms stitle' -evalue 1e-20 -out n.clc.allfinal.out -num_threads 40

/shelf/apps/pjt6/conda/envs/python27/bin/blobtools create -i curated.fasta  -s temp.sam -t n.clc.allfinal.out -o curated.fasta.blobplots
 
 mkdir allfinal.fa.blobplots
 cp curated.fasta.blobplots.blobDB.json ./allfinal.fa.blobplots
 
/shelf/apps/pjt6/conda/envs/python27/bin/blobtools view -i  curated.fasta.blobplots.blobDB.json -o allfinal.fa.blobplots/
 
/shelf/apps/pjt6/conda/envs/python27/bin/blobtools blobplot -i curated.fasta.blobplots.blobDB.json -o allfinal.fa.blobplots/ 

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

