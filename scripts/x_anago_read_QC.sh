#!/bin/bash

seq_dir="/proj/applied_bioinformatics/users/x_anago/MedBioinfo/data/sra_fastq"
accession_file="/proj/applied_bioinformatics/users/x_anago/MedBioinfo/analyses/x_anago_run_accessions.txt"
appt_path="/proj/applied_bioinformatics/users/x_anago/images/appbio.sif"

echo "script start`date`: Creating file with accession numbers..."

# Extract run accession numbers from db
sqlite3 -noheader -csv -batch /proj/applied_bioinformatics/common_data/sample_collab.db \
	"select run_accession from sample_annot spl left join sample2bioinformatician s2b using(patient_code) where username='x_anago';" > \
	/proj/applied_bioinformatics/users/x_anago/MedBioinfo/analyses/x_anago_run_accessions.txt 

# create data subdirectory
mkdir ${seq_dir}

# Download data
cat ${accession_file} | srun --cpus-per-task=1 singularity exec /proj/applied_bioinformatics/users/x_anago/images/appbio.sif xargs fastq-dump --gzip --readids --split-files --disable-multithreading

# Check number of files
ls ${seq_dir}/*.gz | wc

# Count number of sequences using bash
for i in $(ls ${seq_dir}/*.gz); do echo $i; zcat $i | grep ^@ | wc; done

# Look for adapters
# Search for adapter one in sequences _1
for i in $(ls ${seq_dir}/*_1.fastq.gz); do singularity exec $appt_path seqkit locate -p AGATCGGAAGAGCAC $i |wc -l; done
# Search for adapter two in sequences _2
for i in $(ls ${seq_dir}/*_2.fastq.gz); do singularity exec $appt_path seqkit locate -p AGATCGGAAGAGCGT $i |wc -l; done

# Calculate sequences stats
srun --cpus-per-task=1 --threads 1 singularity exec $appt_dir seqkit stats *.gz -T

# Create directory for fastqc
mkdir /proj/applied_bioinformatics/users/x_anago/MedBioinfo/analyses/fastqc

# Create fastq for each file
for i in $(cat /proj/applied_bioinformatics/users/x_anago/MedBioinfo/analyses/x_anago_run_accessions.txt); do srun --cpus-per-task=2 --time=00:30:00 singularity exec /proj/applied_bioinformatics/users/x_anago/images/appbio.sif fastqc ${i}_1.fastq.gz ${i}_2.fastq.gz -t 2; done

# Tranfer to local computer
scp x_anago@tetralith.nsc.liu.se:/proj/applied_bioinformatics/users/x_anago/Medbioinfo/analyses/fastqc/*.html /home/anagon@ad.cmm.se/Documents/Courses/Applied_bioinformatics/fastqc_files

# Create merged_pairs dir
mkdir /proj/applied_bioinformatics/users/x_anago/MedBioinfo/data/merged_pairs

# Merge files
for i in $(cat /proj/applied_bioinformatics/users/x_anago/MedBioinfo/analyses/x_anago_run_accessions.txt); do srun --cpus-per-task=2 --time=00:30:00 singularity exec /proj/applied_bioinformatics/users/x_anago/images/appbio.sif flash ${i}_1.fastq.gz ${i}_2.fastq.gz 2>&1 | tee -a x_anago_flash.log

echo "script end: `date`"
