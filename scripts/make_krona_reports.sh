#!/bin/bash

#SBATCH -J make_krone_rep
#SBATCH -A naiss2024-22-540
#SBATCH --time=00:30:00
#SBATCH --cpus-per-task=1
#SBATCH -o /proj/applied_bioinformatics/users/x_anago/slurm_outpus/slurm.%A.%a.out
#SBATCH -e /proj/applied_bioinformatics/users/x_anago/slurm_outpus/slurm.%A.%a.err
#SBATCH --array=1-12

# Define data paths
in_path="/proj/applied_bioinformatics/users/x_anago/MedBioinfo/analyses/kraken2"
out_path="/proj/applied_bioinformatics/users/x_anago/MedBioinfo/analyses/krona"
accnum_file="/proj/applied_bioinformatics/users/x_anago/MedBioinfo/analyses/x_anago_run_accessions.txt"
singularity_path="/proj/applied_bioinformatics/users/x_anago/images/kraken_ubuntu.sif"
#singularity_path="/proj/applied_bioinformatics/common_data/kraken2.sif"

# Extract IDs from file of patients
accnum=$(sed -n "$SLURM_ARRAY_TASK_ID"p ${accnum_file})

# Run krona
srun --job-name=kronarep_${accnum} kreport2krona.py -r ${in_path}/${accnum}_kraken_report.out -o ${out_path}/${accnum}_krona

# Remove preffixes
srun --job-name=edit_out${accnum} sed -i 's/[skpcofg]__//g' ${out_path}/${accnum}_krona #> ${out_path}/${accnum}_krona_declutter.txt

# Create interactive reports
srun --job-name=krona_int${accnum} singularity exec -B /proj:/proj ${singularity_path} ktImportText ${out_path}/${accnum}_krona -o ${out_path}/${accnum}_krona.html 
