set -e
true
/gpfs1/apps/conda/pjt6/conda/envs/spades/bin/spades-hammer /gpfs1/scratch/bioinf/pjt6/Xr/corrected/configs/config.info
/gpfs1/apps/conda/pjt6/conda/bin/python /gpfs1/apps/conda/pjt6/conda/envs/spades/share/spades/spades_pipeline/scripts/compress_all.py --input_file /gpfs1/scratch/bioinf/pjt6/Xr/corrected/corrected.yaml --ext_python_modules_home /gpfs1/apps/conda/pjt6/conda/envs/spades/share/spades --max_threads 64 --output_dir /gpfs1/scratch/bioinf/pjt6/Xr/corrected --gzip_output
true
true
/gpfs1/apps/conda/pjt6/conda/envs/spades/bin/spades-core /gpfs1/scratch/bioinf/pjt6/Xr/K55/configs/config.info
/gpfs1/apps/conda/pjt6/conda/envs/spades/bin/spades-core /gpfs1/scratch/bioinf/pjt6/Xr/K77/configs/config.info
/gpfs1/apps/conda/pjt6/conda/envs/spades/bin/spades-core /gpfs1/scratch/bioinf/pjt6/Xr/K99/configs/config.info
/gpfs1/apps/conda/pjt6/conda/envs/spades/bin/spades-core /gpfs1/scratch/bioinf/pjt6/Xr/K111/configs/config.info
/gpfs1/apps/conda/pjt6/conda/bin/python /gpfs1/apps/conda/pjt6/conda/envs/spades/share/spades/spades_pipeline/scripts/copy_files.py /gpfs1/scratch/bioinf/pjt6/Xr/K111/before_rr.fasta /gpfs1/scratch/bioinf/pjt6/Xr/before_rr.fasta /gpfs1/scratch/bioinf/pjt6/Xr/K111/final_contigs.fasta /gpfs1/scratch/bioinf/pjt6/Xr/contigs.fasta /gpfs1/scratch/bioinf/pjt6/Xr/K111/first_pe_contigs.fasta /gpfs1/scratch/bioinf/pjt6/Xr/first_pe_contigs.fasta /gpfs1/scratch/bioinf/pjt6/Xr/K111/scaffolds.fasta /gpfs1/scratch/bioinf/pjt6/Xr/scaffolds.fasta /gpfs1/scratch/bioinf/pjt6/Xr/K111/scaffolds.paths /gpfs1/scratch/bioinf/pjt6/Xr/scaffolds.paths /gpfs1/scratch/bioinf/pjt6/Xr/K111/assembly_graph_with_scaffolds.gfa /gpfs1/scratch/bioinf/pjt6/Xr/assembly_graph_with_scaffolds.gfa /gpfs1/scratch/bioinf/pjt6/Xr/K111/assembly_graph.fastg /gpfs1/scratch/bioinf/pjt6/Xr/assembly_graph.fastg /gpfs1/scratch/bioinf/pjt6/Xr/K111/final_contigs.paths /gpfs1/scratch/bioinf/pjt6/Xr/contigs.paths
true
/gpfs1/apps/conda/pjt6/conda/bin/python /gpfs1/apps/conda/pjt6/conda/envs/spades/share/spades/spades_pipeline/scripts/breaking_scaffolds_script.py --result_scaffolds_filename /gpfs1/scratch/bioinf/pjt6/Xr/scaffolds.fasta --misc_dir /gpfs1/scratch/bioinf/pjt6/Xr/misc --threshold_for_breaking_scaffolds 3
true
