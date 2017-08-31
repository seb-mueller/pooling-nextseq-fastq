#!/bin/bash
# Sebastian Mueller 2017 (sebm@posteo.de)
# copy directory structrue to serve as a skelleton for testing
# rsync -a --filter="-! */" /data/archive_data/all_sainsbury_data/RNASEQ_TRIBE .
# creating dummy files with only few sequences for testing
# for file in $(ls -d -1 /data/archive_data/all_sainsbury_data/RNASEQ_TRIBE/Samples/3-P1511-1/Files/*); do export bn=$(basename $file); zcat $file | head -n 100 | gzip > $bn; done

# ls RNASEQ_TRIBE/Samples/2-PenneC-1/Files/
# PenneC-1_S5_L001_R1_001.fastq.gz  PenneC-1_S5_L002_R2_001.fastq.gz  PenneC-1_S5_L004_R1_001.fastq.gz
# PenneC-1_S5_L001_R2_001.fastq.gz  PenneC-1_S5_L003_R1_001.fastq.gz  PenneC-1_S5_L004_R2_001.fastq.gz
# PenneC-1_S5_L002_R1_001.fastq.gz  PenneC-1_S5_L003_R2_001.fastq.gz
# {project}/Samples/{libname}/Files/{libname}-xx_L00{1-4}_R{1-2}_001.fastq.gz

#pooling_single.sh /home/sm934/bin/pooling_test/RNASEQ_TRIBE/Samples/2-PenneC-1

dir_sample=$1
#basedir=$(dirname $dir_sample)
basefile=$(basename $dir_sample)
dir_local=fastq_pooled

for read in {R1,R2}; do
  for file in $(ls ${dir_sample}/Files/*L001*_${read}_001.fastq.gz); do 
      file_out=${dir_local}/${basefile}_${read}.fastq.gz
      echo -e "--\ncreating "${file_out}
      ls -Llhtr --color ${file//L001/*}
      zcat ${file//L001/*} | gzip > ${file_out}
      ls -Llhrt --color ${file_out}
  done
done
