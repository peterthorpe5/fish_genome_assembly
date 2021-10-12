
cd /mnt/shared/scratch/pthorpe/private/cb/final/cb_funannotate


conda activate funannotate1.8.7


funannotate util tbl2gbk -f fixed.fa  -s "Crenichthys_baileyi" --strain "V.1.0" --tbl annotate_results/Crenichthys_baileyi_V.1.0.tbl


cp .gbk ./annotate_results/

funannotate fix --tbl annotate_results/Crenichthys_baileyi_V.1.0.tbl --input annotate_results/*.gbk


CRENBAI_001751  Illegal start codon (and 4 internal stops). Probably wrong genetic code [1]
CRENBAI_001752  Illegal start codon (and 16 internal stops). Probably wrong genetic code [1]
CRENBAI_001753  Illegal start codon (and 9 internal stops). Probably wrong genetic code [1]
CRENBAI_003245  Protein name ends with hyphen
CRENBAI_020104  Protein name ends with hyphen
[May 31 05:09 PM]: Manually edit the tbl file annotate_results/Crenichthys_baileyi_V.1.0.tbl, then run:

funannotate fix -i annotate_results/Crenichthys_baileyi_V.1.0.gbk -t annotate_results/Crenichthys_baileyi_V.1.0.tbl --drop remove

# run tbl to asn manually. 
/mnt/shared/scratch/pthorpe/apps/conda/envs/funannotate/bin/python \
/mnt/shared/scratch/pthorpe/apps/conda/envs/funannotate/lib/python2.7/site-packages/funannotate/aux_scripts/tbl2asn_parallel.py \
-i /mnt/shared/scratch/pthorpe/private/cb/final/cb_funannotate/annotate_results/Crenichthys_baileyi_V.1.0.tbl \
-f /mnt/shared/scratch/pthorpe/private/cb/final/cb_funannotate/annotate_results/Crenichthys_baileyi_V.1.0.scaffolds.fa \
-o /mnt/shared/scratch/pthorpe/private/cb/final/cb_funannotate/annotate_results/ \
--sbt /mnt/shared/scratch/pthorpe/apps/conda/envs/funannotate/lib/python2.7/site-packages/funannotate/config/test.sbt \
-d report.discrepency.txt -s Crenichthys_baileyi -v 1 -c 32 --strain V.1.0


# these should be in there but crahses when I try 
-t -l paired-ends 