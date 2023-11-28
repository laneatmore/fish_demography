#!/bin/bash
#SBATCH --account=nn9244k
#SBATCH --time=01:00:00
#SBATCH --job-name=update_chr
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4G

set -o errexit #Make bash exit on any error
set -o nounset #Treat any unset variable as errors

#Set up the job environment

module --quiet purge
module load PLINK/1.9b_6.13-x86_64

module load Anaconda3/2022.10

export PS1=\$

source ${EBROOTANACONDA3}/etc/profile.d/conda.sh

conda deactivate &>/dev/null
conda activate /cluster/projects/nn9244k/python3

prefix=$1
chr=$2

python replace_chr_tped.py $prefix $chr

plink --bfile $prefix --chr-set 26 --double-id \
--update-chr $prefix.updated.chr.txt [1] [2] --make-bed --out \
$prefix.updated