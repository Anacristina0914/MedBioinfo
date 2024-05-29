#!/bin/bash

# Singularity image path
img="/proj/applied_bioinformatics/users/x_anago/images/appbio.sif"
fastq_folder="/proj/applied_bioinformatics/users/x_anago/MedBioinfo/data/sra_fastq"

for i in $(cat /proj/applied_bioinformatics/users/x_anago/MedBioinfo/analyses/x_anago_run_accessions.txt); do singularity exec ${img} flash ${fastq_folder}/${i}_1.fastq.gz ${fastq_folder}/${i}_2.fastq.gz -o ${i}.flash; done
