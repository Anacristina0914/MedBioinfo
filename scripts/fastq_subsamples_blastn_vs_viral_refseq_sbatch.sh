#!/bin/bash
#
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --time=0-02:00
#SBATCH -o /proj/applied_bioinformatics/users/x_anago/slurm_outpus/slurm.%A.%a.out
#SBATCH -e /proj/applied_bioinformatics/users/x_anago/slurm_outpus/slurm.%A.%a.err
#SBATCH --job-name=blastnseqs

# Preparing work (cd to working dir, get hold of input data, convert/un-compress input data when needed etc.)
workdir="/proj/applied_bioinformatics/users/x_anago/MedBioinfo/analyses/blastn"
datadir="/proj/applied_bioinformatics/users/x_anago/MedBioinfo/data/merged_pairs"
acc_file="/proj/applied_bioinformatics/users/x_anago/MedBioinfo/analyses/x_anago_run_accessions.txt"

echo START: `date`

mkdir -p ${workdir}      # -p because it creates all required dir levels **and** doesn't throw an error if the dir exists :)
cd ${workdir}

# this extracts the item number $SLURM_ARRAY_TASK_ID from the file of accnums
seq_id="ERR6913233"
db_file="/proj/applied_bioinformatics/users/x_anago/MedBioinfo/data/blast_db/refseq_viral_genomic"
# alternatively, just extract the input file as the item number $SLURM_ARRAY_TASK_ID in the data dir listing
# this alternative is less handy since we don't get hold of the isolated "accnum", which is very handy to name the srun step below :)
# input_file=$(ls "${datadir}/*.fastq.gz" | sed -n ${SLURM_ARRAY_TASK_ID}p)

# Need to include a script to convert fastq into fasta files



#################################################################
# Start work
srun --threads 1 blastn -query ${datadir}/${seq_id}_100seqs.fasta -db ${db_file} -evalue 1e-20 -perc_identity 80 -out ${seq_id}_100.txt -outfmt 6 &

srun --threads 1 blastn -query ${datadir}/${seq_id}_1000seqs.fasta -db ${db_file} -evalue 1e-20 -perc_identity 80 -out ${seq_id}_1000.txt -outfmt 6 &

srun --threads 1 blastn -query ${datadir}/${seq_id}_10000seqs.fasta -db ${db_file} -evalue 1e-20 -perc_identity 80 -out ${seq_id}_10000.txt -outfmt 6

wait
echo END: `date`
