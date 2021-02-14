#$ -cwd
#
cd /storage/home/users/pjt6/ros/after_pilon/
#python run_pipeline.py
sleep 4567890

conda activate python27
conda activate repeatmasking

# genomtools is in path

#/shelf/apps/pjt6/apps/TransposonPSI_08222010/transposonPSI.pl GROS_nanopore_v1.0.fasta nuc

# LTRharvest in genome tools  http://genometools.org/documents/ltrharvest.pdf


#make the enhanced database
#gt suffixerator -db GROS_nanopore_v1.0.fasta -indexname gp -tis -suf -lcp -des -ssp -sds -dna


#search for the beasties. 

gt ltrharvest -index gp -mintsd 5 -maxtsd 100 > Gr_LTR_harvest.out


# (optional sequence clusterin gof output

#mkvtree .... look at the pdf. 
