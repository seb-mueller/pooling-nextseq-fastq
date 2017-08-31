# copy directory structrue to serve as a skelleton for testing
# rsync -a --filter="-! */" /data/archive_data/all_sainsbury_data/RNASEQ_TRIBE .
# creating dummy files with only few sequences for testing
# for file in $(ls -d -1 /data/archive_data/all_sainsbury_data/RNASEQ_TRIBE/Samples/3-P1511-1/Files/*); do export bn=$(basename $file); zcat $file | head -n 100 | gzip > $bn; done

# ls RNASEQ_TRIBE/Samples/2-PenneC-1/Files/
# PenneC-1_S5_L001_R1_001.fastq.gz  PenneC-1_S5_L002_R2_001.fastq.gz  PenneC-1_S5_L004_R1_001.fastq.gz
# PenneC-1_S5_L001_R2_001.fastq.gz  PenneC-1_S5_L003_R1_001.fastq.gz  PenneC-1_S5_L004_R2_001.fastq.gz
# PenneC-1_S5_L002_R1_001.fastq.gz  PenneC-1_S5_L003_R2_001.fastq.gz
# {project}/Samples/{libname}/Files/{libname}-xx_L00{1-4}_R{1-2}_001.fastq.gz

dir_raw_data=$1/Samples
dir_local=$2
echo $dir_raw_data
echo $1

for dir_sample in $(ls ${dir_raw_data}); do
    for file in $(ls ${dir_raw_data}/${dir_sample}/Files/*L001*_R{1,2}_001.fastq.gz); do
        basefile=$(basename $file)
        basedir=$(dirname $file)
        file_out=${dir_local}/${basefile//L001/pooled}
        echo -e "--\ncreating "${file_out}
        ls -Llhtr --color ${basedir}/${basefile//L001/*}
        zcat ${basedir}/${basefile//L001/*} | gzip > ${file_out}
        ls -Llhrt --color ${file_out}
    done
done

