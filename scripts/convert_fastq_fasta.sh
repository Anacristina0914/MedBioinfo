#!/bin/bash
#SBATCH -J fastq_to_fasta 
#SBATCH -A naiss2024-22-540
#SBATCH --time 01:00:00
#SBATCH -o /proj/applied_bioinformatics/users/x_anago/slurm_outpus/slurm.%A.%a.out
#SBATCH -e /proj/applied_bioinformatics/users/x_anago/slurm_outpus/slurm.%A.%a.err
#SBATCH --array=1-12

# Define paths
singularity_path="/proj/applied_bioinformatics/users/x_anago/images/appbio.sif"
accnum_file="/proj/applied_bioinformatics/users/x_anago/MedBioinfo/analyses/x_anago_run_accessions.txt"
accnum=$(sed -n "$SLURM_ARRAY_TASK_ID"p ${accnum_file})
seq_path="/proj/applied_bioinformatics/users/x_anago/MedBioinfo/data/sra_fastq"
out_path="/proj/applied_bioinformatics/users/x_anago/MedBioinfo/data/fasta_seqs"

# Convert them from fastq to fasta format
srun --job-name=${accnum}_fastq2fasta_1 singularity exec -B /proj:/proj ${singularity_path} seqkit fq2fa ${seq_path}/${accnum}_1.fastq.gz -o ${out_path}/${accnum}_1.fasta

srun --job-name=${accnum}_fastq2fasta_2 singularity exec -B /proj:/proj ${singularity_path} seqkit fq2fa ${seq_path}/${accnum}_2.fastq.gz -o ${out_path}/${accnum}_2.fasta
