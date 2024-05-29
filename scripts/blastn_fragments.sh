#!/bin/bash

seq_dir="/proj/applied_bioinformatics/users/x_anago/MedBioinfo/data/merged_pairs"
seq_preffix="ERR6913233"#_10000seqs.fasta

for seqn in 100 1000 10000; do blastn $seqn; done 
