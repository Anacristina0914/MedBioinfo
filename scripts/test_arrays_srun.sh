#!/bin/bash

#SBATCH -J test_arrays_sbatch
#SBATCH -A naiss2024-22-540
#SBATCH --time=00:02:00
#SBATCH --cpus-per-task=1
#SBATCH -o /proj/applied_bioinformatics/users/x_anago/slurm_outpus/slurm.%A.%a.out
#SBATCH -e /proj/applied_bioinformatics/users/x_anago/slurm_outpus/slurm.%A.%a.err
#SBATCH --array=1-4

sample_path="/proj/applied_bioinformatics/users/x_anago/MedBioinfo/data/sra_fastq"
db_path="/proj/applied_bioinformatics/common_data/kraken_database"
out_path="/proj/applied_bioinformatics/users/x_anago/MedBioinfo/analyses/kraken2/"
accnum_file="/proj/applied_bioinformatics/users/x_anago/MedBioinfo/analyses/x_anago_run_accessions.txt"

# Extract IDs from file of patients
accnum=$(sed -n "$SLURM_ARRAY_TASK_ID"p ${accnum_file})
input_file_preffix=$(ls "${sample_path}/${accnum}")

# Convert all fastq files into fasta files


# Run kraken on all files
srun --job-name=${accnum} echo ${input_file_preffix}_${accnum}

#srun --job-name=${accnum} echo ${input_file_preffix}_${accnum} 
