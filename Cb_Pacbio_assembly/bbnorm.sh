#!/bin/bash
#$ -cwd
conda activate bbnorm

norm="/shelf/apps/pjt6/conda/envs/bbnorm/bin/bbnorm.sh
in=R1.fq.gz
in2=R2.fq.gz
prefilter
target=100 min=5
out=bbnomr_R1.fq
out2=bbnomr_R2.fq
-Xmx240G
tmpdir=$HOME
threads=32"
echo ${norm} 
eval ${norm}

#pigz -p 50 bbnomr_R?.fq
