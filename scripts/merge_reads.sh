#!/bin/bash

#SBATCH -A naiss2024-22-540
#SBATCH -n 14

# Clear environment
module purge > /dev/null 2>&1

# set up wd
#out_dir="/proj/applied_bioinformatics/users/x_anago/MedBioinfo/data/sra_fastq"
#accession_file="/proj/applied_bioinformatics/users/x_anago/MedBioinfo/analyses/x_anago_run_accessions.txt"

#for i in $(cat /proj/applied_bioinformatics/users/x_anago/MedBioinfo/analyses/x_anago_run_accessions.txt); do srun --cpus-per-task=1 --time=00:30:00 singularity exec /proj/applied_bioinformatics/users/x_anago/images/appbio.sif fastqc ${i}1.fastq.gz ${i}_2.fastq.gz -t 1; done

for i in $(cat /proj/applied_bioinformatics/users/x_anago/MedBioinfo/analyses/x_anago_run_accessions.txt); do srun --cpus-per-task=1 --time=00:30:00 singularity exec /proj/applied_bioinformatics/users/x_anago/images/appbio.sif flash ${i}_1.fastq.gz ${i}_2.fastq.gz 2>&1 --output-suffix ${i}| tee -a x_anago_flash.log; done

#srun --cpus-per-task=1 --time=00:30:00 singularity exec /proj/applied_bioinformatics/users/x_anago/images/appbio.sif xargs -I{} -a /proj/applied_bioinformatics/users/x_anago/MedBioinfo/analyses/x_anago_run_accessions.txt fastq-dump {} --gzip --outdir /desired/output/dir --readids --split-files --disable-multithreading -X 10

