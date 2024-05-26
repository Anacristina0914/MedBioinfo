#!/bin/bash
echo "script start`date`: Creating file with accession numbers..."
# Extract run accession numbers from db
sqlite3 -noheader -csv -batch /proj/applied_bioinformatics/common_data/sample_collab.db \
	"select run_accession from sample_annot spl left join sample2bioinformatician s2b using(patient_code) where username='x_anago';" > \
	/proj/applied_bioinformatics/users/x_anago/MedBioinfo/analyses/x_anago_run_accessions.txt 

echo "script end: `date`"
