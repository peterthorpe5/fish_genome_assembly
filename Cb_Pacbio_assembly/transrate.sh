#!/bin/bash
#$ -cwd
cd /storage/home/users/pjt6/pb_fish/RNAseq


echo "Running transrate to get RNAseq mapping and it will tell you 
statistically what genes may be fusions. "
tran="transrate 
--threads 32
	 --assembly /storage/home/users/pjt6/pb_fish/RNAseq/transrate_results/Trinity-GG/good.Trinity-GG.fasta
	 --left R1.fq.gz 
	 --right R2.fq.gz"
echo ${tran}
eval ${tran}