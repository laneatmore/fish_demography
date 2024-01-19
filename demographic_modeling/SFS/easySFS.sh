#!/bin/bash
#SBATCH --account=nn9244k
#SBATCH --time=10:00:00
#SBATCH --job-name=easySFS
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=15G

#if you need long time
# --partition=long

#If you need hugemem...
# --partition=hugemem

set -o errexit #Make bash exit on any error
set -o nounset #Treat any unset variable as errors

module --quiet purge
module load Anaconda3/2022.10

export PS1=\$

source ${EBROOTANACONDA3}/etc/profile.d/conda.sh

conda deactivate &>/dev/null
conda activate /cluster/projects/nn9244k/python3

prefix=$1

./easySFS.py -i $prefix.vcf.gz -p pops.txt --preview -a -v

##select projections and input them in the following line to run the program
./easySFS.py -i $prefix.vcf.gz -p pops.txt --proj=[insert projection] -a -v
