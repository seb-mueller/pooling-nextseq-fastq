# pooling-nextseq-fastq
Pooling Illumina NextSeq 500 fastq files using a Snakemake directive

## Requirement
* Unix (only tested on Linux)
* [Snakemake](https://snakemake.readthedocs.io/en/stable/)
* Python3 (optional)
* [basemount](https://help.basespace.illumina.com/articles/descriptive/introduction-to-basemount) (optional)

## Usage
Download or clone this repository in your standard software directory (doesn't need to be where the actual data is).

```bash
cd ~/software
git clone https://github.com/seb-mueller/pooling-nextseq-fastq.git
```
Navigate or Create your project folder where you want to pooled data to be created.

```bash
cd ~/analysis
mkdir mynextseqproject
cd mynextseqproject
```
Create a config.yaml file. 
This can be done manual using a text editor. An example config.yaml is included in this repo.
Basically, base directory of where the basemount copied data is sitting needs to be specified as well
as each sample! 
Note: Having to list all samples is a deliberate choice for reproducibility etc. reasons and the config.yaml should be thought of a companion to this project.

The generation can also be automized using the generate_config.py script. 
In this example we are using moch data shipped with this repo:

```bash
python3 ~/software/pooling-nextseq-fastq/generate_config.py --dir ~/software/pooling-nextseq-fastq/mynextseqdir
```

This should generate a config.yaml with the following contend:

    NEXTSEQDIR: /home/sm934/software/pooling-nextseq-fastq/mynextseqdir
    OUTDIR: fastq_pooled
    SAMPLES:
      sample1: null
      sample2: null

```bash
snakemake -s ~/software/pooling-nextseq-fastq/Snakefile
```

Which should generate the following files:

    ├── config.yaml
    ├── fastq_pooled
    │   ├── sample1_R1.fastq.gz
    │   ├── sample1_R2.fastq.gz
    │   ├── sample2_R1.fastq.gz
    │   └── sample2_R2.fastq.gz
    └── logs
        └── pooling_fastq
            ├── sample1.log
            └── sample2.log



## Purpose of this script
This is meant to be an automated pipiline to merge fastq files form the NextSeq 500 machine which we 
are increasingly use. 
Due to the availability of BaseSpace Linux command line interface (CLI) called [basemount](https://help.basespace.illumina.com/articles/descriptive/introduction-to-basemount), it is possible to automate the download
of NGS data. We usually adapt the following workflow:

```bash
basemount ~/basespacemount
cd ~/basespacemount
cp -R mynextseqdir /myarchive
```

The output is a bit convoluted, but contains all we need in a structured way.
Annoyingly, the data is split up into 4 lanes due to the nature of the machine. This can be considered as technial replicats and should be pooled, which is the pupose of this program.


    mynextseqdir
    ├── AppResults
    ├── AppSessions
    │   └── FASTQ Generation 2017-08-09 10:29:30Z
    │       ├── Logs
    │       ├── Logs.metadata
    │       └── Properties
    │           ├── Input.run-id.attributes
    │           │   └── 0
    │           ├── Input.Runs
    │           ├── Output.Projects
    │           └── Output.Samples
    ├── Properties
    └── Samples
        ├── sample1
        │   ├── Files
        │   │   ├── samp1_L001_R1_001.fastq.gz
        │   │   ├── samp1_L001_R2_001.fastq.gz
        │   │   ├── samp1_L002_R1_001.fastq.gz
        │   │   ├── samp1_L002_R2_001.fastq.gz
        │   │   ├── samp1_L003_R1_001.fastq.gz
        │   │   ├── samp1_L003_R2_001.fastq.gz
        │   │   ├── samp1_L004_R1_001.fastq.gz
        │   │   └── samp1_L004_R2_001.fastq.gz
        │   ├── Files.metadata
        │   └── Properties
        │       ├── Input.Runs
        │       └── PerLaneAttributes.LaneNumbers
        └── sample2
            ├── Files
            │   ├── samp2_L001_R1_001.fastq.gz
            │   ├── samp2_L001_R2_001.fastq.gz
            │   ├── samp2_L002_R1_001.fastq.gz
            │   ├── samp2_L002_R2_001.fastq.gz
            │   ├── samp2_L003_R1_001.fastq.gz
            │   ├── samp2_L003_R2_001.fastq.gz
            │   ├── samp2_L004_R1_001.fastq.gz
            │   └── samp2_L004_R2_001.fastq.gz
            ├── Files.metadata
            └── Properties
                ├── Input.Runs
                └── PerLaneAttributes.LaneNumbers
