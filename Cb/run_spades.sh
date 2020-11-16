set -e
true
/usr/bin/python /gpfs1/apps/conda/pjt6/conda/envs/spades/share/spades/spades_pipeline/scripts/preprocess_contigs.py --args_filename /gpfs1/scratch/bioinf/pjt6/cb_clc/split_input/tmp/contigs --dst /gpfs1/scratch/bioinf/pjt6/cb_clc/split_input --threshold_for_breaking_additional_contigs 10
true
true
/gpfs1/apps/conda/pjt6/conda/envs/spades/bin/spades-core /gpfs1/scratch/bioinf/pjt6/cb_clc/K55/configs/config.info
/gpfs1/apps/conda/pjt6/conda/envs/spades/bin/spades-core /gpfs1/scratch/bioinf/pjt6/cb_clc/K77/configs/config.info
/gpfs1/apps/conda/pjt6/conda/envs/spades/bin/spades-core /gpfs1/scratch/bioinf/pjt6/cb_clc/K99/configs/config.info
/gpfs1/apps/conda/pjt6/conda/envs/spades/bin/spades-core /gpfs1/scratch/bioinf/pjt6/cb_clc/K117/configs/config.info
/usr/bin/python /gpfs1/apps/conda/pjt6/conda/envs/spades/share/spades/spades_pipeline/scripts/copy_files.py /gpfs1/scratch/bioinf/pjt6/cb_clc/K117/before_rr.fasta /gpfs1/scratch/bioinf/pjt6/cb_clc/before_rr.fasta /gpfs1/scratch/bioinf/pjt6/cb_clc/K117/final_contigs.fasta /gpfs1/scratch/bioinf/pjt6/cb_clc/contigs.fasta /gpfs1/scratch/bioinf/pjt6/cb_clc/K117/first_pe_contigs.fasta /gpfs1/scratch/bioinf/pjt6/cb_clc/first_pe_contigs.fasta /gpfs1/scratch/bioinf/pjt6/cb_clc/K117/scaffolds.fasta /gpfs1/scratch/bioinf/pjt6/cb_clc/scaffolds.fasta /gpfs1/scratch/bioinf/pjt6/cb_clc/K117/scaffolds.paths /gpfs1/scratch/bioinf/pjt6/cb_clc/scaffolds.paths /gpfs1/scratch/bioinf/pjt6/cb_clc/K117/assembly_graph_with_scaffolds.gfa /gpfs1/scratch/bioinf/pjt6/cb_clc/assembly_graph_with_scaffolds.gfa /gpfs1/scratch/bioinf/pjt6/cb_clc/K117/assembly_graph.fastg /gpfs1/scratch/bioinf/pjt6/cb_clc/assembly_graph.fastg /gpfs1/scratch/bioinf/pjt6/cb_clc/K117/final_contigs.paths /gpfs1/scratch/bioinf/pjt6/cb_clc/contigs.paths
true
/usr/bin/python /gpfs1/apps/conda/pjt6/conda/envs/spades/share/spades/spades_pipeline/scripts/breaking_scaffolds_script.py --result_scaffolds_filename /gpfs1/scratch/bioinf/pjt6/cb_clc/scaffolds.fasta --misc_dir /gpfs1/scratch/bioinf/pjt6/cb_clc/misc --threshold_for_breaking_scaffolds 3
true
