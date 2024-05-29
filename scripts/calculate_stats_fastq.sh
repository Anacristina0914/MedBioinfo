#!/bin/bash

#SBATCH -A naiss2024-22-540
#SBATCH --time 0:30:00
#SBATCH -n 6

# Clear environment
module purge > /dev/null 2>&1

# set up wd
out_dir="/proj/applied_bioinformatics/users/x_anago/MedBioinfo/data/sra_fastq"
accession_file="/proj/applied_bioinformatics/users/x_anago/MedBioinfo/analyses/x_anago_run_accessions.txt"

srun --cpus-per-task=1 --threads 1 singularity exec /proj/applied_bioinformatics/users/x_anago/images/appbio.sif seqkit stats *.gz -T
#cat ${accession_file} | srun --cpus-per-task=1 singularity exec /proj/applied_bioinformatics/users/x_anago/images/appbio.sif xargs fastq-dump --gzip --readids --split-files --disable-multithreading    

