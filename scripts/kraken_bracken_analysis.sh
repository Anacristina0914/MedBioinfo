#!/bin/bash

#SBATCH -J kraken_analysis_mpa
#SBATCH -A naiss2024-22-540
#SBATCH --time=01:30:00
#SBATCH --cpus-per-task=1
#SBATCH --mem=100GB
#SBATCH -o /proj/applied_bioinformatics/users/x_anago/slurm_outpus/slurm.%A.%a.out
#SBATCH -e /proj/applied_bioinformatics/users/x_anago/slurm_outpus/slurm.%A.%a.err
#SBATCH --array=1-12

# Define data paths
sample_path="/proj/applied_bioinformatics/users/x_anago/MedBioinfo/data/fasta_seqs"
db_path="/proj/applied_bioinformatics/common_data/kraken_database"
out_path="/proj/applied_bioinformatics/users/x_anago/MedBioinfo/analyses/kraken2"
accnum_file="/proj/applied_bioinformatics/users/x_anago/MedBioinfo/analyses/x_anago_run_accessions.txt"
#singularity_path="/proj/applied_bioinformatics/users/x_anago/images/kraken_ubuntu.sif"
singularity_path="/proj/applied_bioinformatics/common_data/kraken2.sif"

# Extract IDs from file of patients
accnum=$(sed -n "$SLURM_ARRAY_TASK_ID"p ${accnum_file})
input_file_preffix="${sample_path}/${accnum}"
echo "${input_file_preffix}_1.fasta"
# Run kraken
srun --job-name=kraken2_${accnum} singularity exec -B /proj:/proj ${singularity_path} kraken2 --paired ${input_file_preffix}_1.fasta ${input_file_preffix}_2.fasta -db ${db_path} --output ${out_path}/${accnum}_kraken.out --report ${out_path}/${accnum}_kraken_report.out

# Then run bracken
srun --job-name=bracken_${accnum} singularity exec -B /proj:/proj ${singularity_path} bracken -d ${db_path} -i ${out_path}/${accnum}_kraken_report.out -o ${out_path}/${accnum}_bracken_report.out -w ${out_path}/${accnum}_kraken_report_bracken.out 
