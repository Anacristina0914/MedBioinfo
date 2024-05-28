#!/bin/bash

#SBATCH -J make_blastdb
#SBATCH -A naiss2024-22-540
#SBATCH --time 0:30:00
#SBATCH -n 2

# Clear environment
module purge > /dev/null 2>&1

# set up wd
out_dir="/proj/applied_bioinformatics/users/x_anago/MedBioinfo/data/blast_db"
viral_genome_path="/proj/applied_bioinformatics/common_data/refseq_viral_split/*"

zcat ${viral_genome_path} | makeblastdb -out ${out_dir}/refseq_viral_genomic -dbtype 'nucl' -title 'viral_refseq'

    

