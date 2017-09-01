# python3 generate_config.py --dir ~/archive/mynextseqproject
import argparse
import os
import yaml
parser = argparse.ArgumentParser()
# args = parser.parse_args(['--T', 'test', 'sim.cells'])
# parser.add_argument("--dir", type=argparse.FileType('r'), required=True)
parser.add_argument("--dir", help="NextSeq root Directory", required=True)
args = parser.parse_args()
mydir = args.dir
sampleAll = os.listdir(mydir + "/Samples")
sampleAll = mydir + "/Samples"

sampleDirs = [f.name for f in os.scandir(sampleAll) if not f.name.startswith('.') and f.is_dir() ]

# in order to write a yaml file, the list containing the sample dirs
# have to be converted into a dict for yaml.dump to do the right thing
# check first if file exists and prompt a warning
sampleDict = dict.fromkeys(sampleDirs)

allDict = {'OUTDIR': 'fastq_pooled',
           'NEXTSEQDIR': mydir,
           'SAMPLES': sampleDict}
with open('config.yaml', 'w') as yaml_file:
    yaml.dump(allDict, yaml_file, default_flow_style=False)
