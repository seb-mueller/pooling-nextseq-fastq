"""Pooling paired-end Fastq files which from 4 lanes which are output of Illumina NextSeq 500
    Since those 4 lanes are technical replicates they can be pooled which is the purpose of this script.
    This makefile assumes the folder structure produced by basespace and 
    goes through all library folders creating 2 files, one for each pair ({sample}_R{1,2}.fastq.gz """

# to make shell rule to work we need to determine the base path of Snakefile since we expect 
# the scripts directory there as well
SRCDIR = srcdir("")

configfile: "config.yaml"

# a pseudo-rule that collects the target files
rule all:
    input:
         expand(config["OUTDIR"] + "/{sample}_R1.fastq.gz", sample=config["SAMPLES"])

rule pooling_fastqc:
    input:
         #fq=expand(NEXTSEQDIR + "/Samples/{sample}",sample=config["SAMPLES"])
         config["NEXTSEQDIR"] + "/Samples/{sample}"
    output:
         config["OUTDIR"] + "{sample}_R1.fastq.gz",
         config["OUTDIR"] + "{sample}_R2.fastq.gz"
    log:
         "logs/pooling_fastq/{sample}.log"
    shell:
        # Note, Snakemake doesn't support shell scripts as "scripts". Using "shell" instead.
        "bash {SRCDIR}/scripts/pooling_nextseq500_singlesample.sh {input} > {log}"
