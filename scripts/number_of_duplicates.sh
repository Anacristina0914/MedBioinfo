#!/bin/bash

#CH -A naiss2024-22-540
#H --time 0:30:00

# Clear environment
module purge > /dev/null 2>&1

# set up wd
out_dir="/proj/applied_bioinformatics/users/x_anago/MedBioinfo/data/sra_fastq"
accession_file="/proj/applied_bioinformatics/users/x_anago/MedBioinfo/analyses/x_anago_run_accessions.txt"

for i in $(ls *.gz); do singularity exec /proj/applied_bioinformatics/users/x_anago/images/appbio.sif seqkit rmdup -s -o unique_$i; done
#cat ${accession_file} | srun --cpus-per-task=1 singularity exec /proj/applied_bioinformatics/users/x_anago/images/appbio.sif xargs fastq-dump --gzip --readids --split-files --disable-multithreading    

