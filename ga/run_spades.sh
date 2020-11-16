set -e
true
/gpfs1/apps/conda/pjt6/conda/envs/spades/bin/spades-hammer /gpfs1/scratch/bioinf/pjt6/Ga/corrected/configs/config.info
/gpfs1/apps/conda/pjt6/conda/bin/python /gpfs1/apps/conda/pjt6/conda/envs/spades/share/spades/spades_pipeline/scripts/compress_all.py --input_file /gpfs1/scratch/bioinf/pjt6/Ga/corrected/corrected.yaml --ext_python_modules_home /gpfs1/apps/conda/pjt6/conda/envs/spades/share/spades --max_threads 64 --output_dir /gpfs1/scratch/bioinf/pjt6/Ga/corrected --gzip_output
true
true
/gpfs1/apps/conda/pjt6/conda/envs/spades/bin/spades-core /gpfs1/scratch/bioinf/pjt6/Ga/K55/configs/config.info
/gpfs1/apps/conda/pjt6/conda/envs/spades/bin/spades-core /gpfs1/scratch/bioinf/pjt6/Ga/K77/configs/config.info
/gpfs1/apps/conda/pjt6/conda/envs/spades/bin/spades-core /gpfs1/scratch/bioinf/pjt6/Ga/K99/configs/config.info
/gpfs1/apps/conda/pjt6/conda/bin/python /gpfs1/apps/conda/pjt6/conda/envs/spades/share/spades/spades_pipeline/scripts/copy_files.py /gpfs1/scratch/bioinf/pjt6/Ga/K99/before_rr.fasta /gpfs1/scratch/bioinf/pjt6/Ga/before_rr.fasta /gpfs1/scratch/bioinf/pjt6/Ga/K99/final_contigs.fasta /gpfs1/scratch/bioinf/pjt6/Ga/contigs.fasta /gpfs1/scratch/bioinf/pjt6/Ga/K99/first_pe_contigs.fasta /gpfs1/scratch/bioinf/pjt6/Ga/first_pe_contigs.fasta /gpfs1/scratch/bioinf/pjt6/Ga/K99/scaffolds.fasta /gpfs1/scratch/bioinf/pjt6/Ga/scaffolds.fasta /gpfs1/scratch/bioinf/pjt6/Ga/K99/scaffolds.paths /gpfs1/scratch/bioinf/pjt6/Ga/scaffolds.paths /gpfs1/scratch/bioinf/pjt6/Ga/K99/assembly_graph_with_scaffolds.gfa /gpfs1/scratch/bioinf/pjt6/Ga/assembly_graph_with_scaffolds.gfa /gpfs1/scratch/bioinf/pjt6/Ga/K99/assembly_graph.fastg /gpfs1/scratch/bioinf/pjt6/Ga/assembly_graph.fastg /gpfs1/scratch/bioinf/pjt6/Ga/K99/final_contigs.paths /gpfs1/scratch/bioinf/pjt6/Ga/contigs.paths
true
/gpfs1/apps/conda/pjt6/conda/bin/python /gpfs1/apps/conda/pjt6/conda/envs/spades/share/spades/spades_pipeline/scripts/breaking_scaffolds_script.py --result_scaffolds_filename /gpfs1/scratch/bioinf/pjt6/Ga/scaffolds.fasta --misc_dir /gpfs1/scratch/bioinf/pjt6/Ga/misc --threshold_for_breaking_scaffolds 3
true
