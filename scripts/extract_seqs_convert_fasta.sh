!#/bin/bash

singularity_path="/proj/applied_bioinformatics/users/x_anago/images/appbio.sif"

# make sequence pairs using flash


# Extract some sequences 
seq_path="/proj/applied_bioinformatics/users/x_anago/MedBioinfo/data/merged_pairs/"
seq_preffix="ERR6913233" #.flash.extendedFrags.fastq"
for i in 100 1000 10000; do singularity exec $singularity_path seqkit head -n $i ${seq_path}/${seq_preffix}.flash.extendedFrags.fastq -o ${seq_preffix}_${i}seqs.fastq; done

# Convert them from fastq to fasta format
for i in 100 1000 10000; do singularity exec $singularity_path seqkit fq2fa ${seq_path}/${seq_preffix}_{i}seqs.fastq -o ${seq_preffix}_${i}seqs.fasta; done

