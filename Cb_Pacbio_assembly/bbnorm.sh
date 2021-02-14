#!/bin/bash
#$ -cwd
cd /storage/home/users/pjt6/pb_fish/RNAseq/

conda activate bbnorm

norm="/shelf/apps/pjt6/conda/envs/bbnorm/bin/bbnorm.sh
in=R1.fq
in2=R2.fq
prefilter
target=100 min=5
out=bbnomr_R1.fq
out2=bbnomr_R2.fq
-Xmx350G
tmpdir=$HOME
threads=50"
echo ${norm} 
eval ${norm}

#pigz -p 50 bbnomr_R?.fq
