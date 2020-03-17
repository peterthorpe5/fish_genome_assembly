#$ -cwd
#$ -l hostname="n13-16-256-morbo"
#$ -pe smp 15
cd /home/pt40963/scratch/fish


#cd /home/pt40963/scratch/fish/cb
#pigz -p 30 -d *
#/mnt/apps/clcBio/4.1.0/clc_assembler --cpus 15 -m 240 -w 64 -b 77 -v -o cb.clc.EC.fa -p fb ss 200 800 -q -i *1.fq.00.0_0.cor.fastq  *2.fq.00.0_0.cor.fastq
#
#pigz --fast -p 30 *
#
####################################
#cd /home/pt40963/scratch/fish/ga
#pigz --fast -p 30 -d *
#
#/mnt/apps/clcBio/4.1.0/clc_assembler --cpus 15 -m 240 -w 64 -b 77 -v -o ga.clc.EC.fa -p fb ss 200 800 -q -i *1.fq.00.0_0.cor.fastq  *2.fq.00.0_0.cor.fastq
#
#/mnt/apps/clcBio/4.1.0/clc_assembler --cpus 15 -m 240 -w 64 -b 77 -v -o ga.clc.Raw.fa -p fb ss 200 800 -q -i *L2_1.fq *L2_2.fq
#
#pigz --fast -p 30 *
#
#
#####################################
#cd /home/pt40963/scratch/fish/xc
#pigz --fast -p 30 -d *
#
#/mnt/apps/clcBio/4.1.0/clc_assembler --cpus 15 -m 240 -w 64 -b 77 -v -o xc.clc.EC.fa -p fb ss 200 800 -q -i *1.fq.00.0_0.cor.fastq  *2.fq.00.0_0.cor.fastq
#
#/mnt/apps/clcBio/4.1.0/clc_assembler --cpus 15 -m 240 -w 64 -b 77 -v -o xc.clc.Raw.fa -p fb ss 200 800 -q -i *L2_1.fq *L2_2.fq
#
#pigz --fast -p 30 *
#
####################################
cd /home/pt40963/scratch/fish/xr
pigz -p 30 -d *

/mnt/apps/clcBio/4.1.0/clc_assembler --cpus 15 -m 240 -w 64 -b 77 -v -o xr.clc.EC.fa -p fb ss 200 800 -q -i *1.fq.00.0_0.cor.fastq  *2.fq.00.0_0.cor.fastq

/mnt/apps/clcBio/4.1.0/clc_assembler --cpus 15 -m 240 -w 64 -b 77 -v -o xr.clc.Raw.fa -p fb ss 200 800 -q -i *L2_1.fq *L2_2.fq

pigz --fast -p 30 *