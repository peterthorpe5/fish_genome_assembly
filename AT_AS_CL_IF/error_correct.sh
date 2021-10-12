#!/bin/bash
#$ -cwd

conda activate bbnorm


norm="/shelf/apps/pjt6/conda/envs/bbnorm/bin//tadpole.sh
mode=correct
in=R1.fq.gz
in2=R2.fq.gz
mode=correct
out=ec_R1.fq.gz
out2=ec_R2.fq.gz
-Xmx345G
tmpdir=$HOME
threads=16"
echo ${norm} 
eval ${norm}


