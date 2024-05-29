#!/bin/bash

#SBATCH -J multiqc_kraken
#SBATCH -A naiss2024-22-540
#SBATCH --time=00:30:00
#SBATCH --cpus-per-task=1
#SBATCH -o /proj/applied_bioinformatics/users/x_anago/slurm_outpus/slurm.%A.%a.out
#SBATCH -e /proj/applied_bioinformatics/users/x_anago/slurm_outpus/slurm.%A.%a.err

# Define data paths
out_path="/proj/applied_bioinformatics/users/x_anago/MedBioinfo/analyses/multiqc"
in_kraken_path="/proj/applied_bioinformatics/users/x_anago/MedBioinfo/analyses/kraken2"
in_bracken_path="/proj/applied_bioinformatics/users/x_anago/MedBioinfo/analyses/bracken"

#singularity_path="/proj/applied_bioinformatics/users/x_anago/images/kraken_ubuntu.sif"
singularity_path="/proj/applied_bioinformatics/users/x_anago/images/appbio.sif"

# Run multiqc for bracken
srun --job-name=bracken_multiwc singularity exec -B /proj:/proj ${singularity_path} multiqc -n bracken_report -o ${out_path} --title bracken_report -d ${in_bracken_path}

# Run multiqc for kraken
#srun --job-name=kraken_multiqc singularity exec -B /proj:/proj ${singularity_path} multiqc -n kraken_report -o ${out_path} --title kraken_report -d ${in_kraken_path}
