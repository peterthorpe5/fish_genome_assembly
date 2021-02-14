#$ -cwd
#
cd /storage/home/users/pjt6/pb_fish/RNAseq

conda activate python27
conda activate repeatmasking


python run_pipeline.py


# genomtools is in path

#/shelf/apps/pjt6/apps/TransposonPSI_08222010/transposonPSI.pl Crenichthys_baileyi.v1.0.fasta nuc

# LTRharvest in genome tools  http://genometools.org/documents/ltrharvest.pdf


#make the enhanced database
#gt suffixerator -db Crenichthys_baileyi.v1.0.fasta -indexname gp -tis -suf -lcp -des -ssp -sds -dna


#search for the beasties. 

#gt ltrharvest -index gp -mintsd 5 -maxtsd 100 > Gr_LTR_harvest.out


# (optional sequence clusterin gof output

#mkvtree .... look at the pdf. 
