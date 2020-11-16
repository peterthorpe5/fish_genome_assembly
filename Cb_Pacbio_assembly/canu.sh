#!/bin/bash
#$ -cwd



cd /storage/home/users/pjt6/pb_fish/

/storage/home/users/pjt6/pb_fish/canu-2.1.1/bin/canu  \
-p fish_normal \
    -d fish_normal genomeSize=1800m -pacbio all.fastq \
    -useGrid=False -maxMemory=120 -maxThreads=28 corOutCoverage=300


/storage/home/users/pjt6/pb_fish/canu-2.1.1/bin/canu  \
-p fish_300X_CMAPSEN_normal \
    -d fish_300X_CMAPSEN_normal genomeSize=1800m -pacbio all.fastq \
    -useGrid=False -maxMemory=120 -maxThreads=28 corOutCoverage=300 corMhapSensitivity=normal

