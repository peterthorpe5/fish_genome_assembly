import os
from Bio import BiopythonWarning
import os
import uuid
import io
import subprocess
import logging
import sys
import csv
import time
import re
import shutil
import platform
import distro
import multiprocessing
import itertools
import hashlib
import math
import gzip
import operator
import textwrap
import errno
import datetime
from natsort import natsorted

#
tRNAout = os.path.join('tRNAscan.out')
tRNAlenOut = os.path.join('tRNAscan.len-filtered.out')

with open(tRNAlenOut, 'w') as lenOut:
    with open(tRNAout, 'r') as infile:
        for line in infile:
            if line.startswith('Sequence') or line.startswith('Name') or line.startswith('--------'):
                lenOut.write('%s' % line)
            else:
                cols = line.split('\t')
                start = cols[2]
                end = cols[3]
                if int(start) < int(end):
                    length = abs(int(end) - int(start))
                else:
                    length = abs(int(start) - int(end))
                if length < 50 or length > 150:
                    continue
                else:
                    lenOut.write('%s' % line)

# now convert to GFF3
trna2gff = os.path.join("/mnt/shared/scratch/pthorpe/private/cb/funannotate/funannotate/aux_scripts/", 'trnascan2gff3.pl')
with open("trnascan.gff3", 'w') as out:
    subprocess.call(['perl', trna2gff, '--input', tRNAlenOut], stdout=out)