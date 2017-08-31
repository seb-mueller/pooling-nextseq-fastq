# pooling-nextseq-fastq
Pooling Illumina NextSeq 500 fastq files using a Snakemake directive

This is meant to be an automated pipiline to merge fastq files form the NextSeq 500 machine which we 
are increasingly use. 
Due to the availability of BaseSpace Linux command line interface (CLI) [1], it is possible to automate the download
of NGS data. We usually adapt the following workflow:

basemount ~/basespacemount
cd ~/basespacemount
cp -R mynextseqdir /myarchive

The output is a bit convoluted, but contains all we need in a structured way.
Annoyingly, the data is split up into 4 lanes due to the nature of the machine. This can be considered as technial replicats and should be pooled, which is the pupose of this program.

[1] https://help.basespace.illumina.com/articles/descriptive/introduction-to-basemount


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
