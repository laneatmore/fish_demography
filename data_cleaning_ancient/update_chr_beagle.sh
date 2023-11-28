#!/bin/bash
#SBATCH --account=nn9244k
#SBATCH --time=04:00:00
#SBATCH --job-name=update_chr
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=10G

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

#for chr in {2..26}; do \
#python update_chr_beagle.py $prefix $chr ; done

for chr in {2..26}; do zcat $prefix.chr$chr.updated.beagle.gz | \
tail -n +2 | gzip > $prefix.chr$chr.updated.noheader.beagle.gz; done

zcat $prefix.chr1.beagle.gz \
$prefix.chr2.updated.noheader.beagle.gz \
$prefix.chr3.updated.noheader.beagle.gz \
$prefix.chr4.updated.noheader.beagle.gz \
$prefix.chr5.updated.noheader.beagle.gz \
$prefix.chr6.updated.noheader.beagle.gz \
$prefix.chr7.updated.noheader.beagle.gz \
$prefix.chr8.updated.noheader.beagle.gz \
$prefix.chr9.updated.noheader.beagle.gz \
$prefix.chr10.updated.noheader.beagle.gz \
$prefix.chr11.updated.noheader.beagle.gz \
$prefix.chr12.updated.noheader.beagle.gz \
$prefix.chr13.updated.noheader.beagle.gz \
$prefix.chr14.updated.noheader.beagle.gz \
$prefix.chr15.updated.noheader.beagle.gz \
$prefix.chr16.updated.noheader.beagle.gz \
$prefix.chr17.updated.noheader.beagle.gz \
$prefix.chr18.updated.noheader.beagle.gz \
$prefix.chr19.updated.noheader.beagle.gz \
$prefix.chr20.updated.noheader.beagle.gz \
$prefix.chr21.updated.noheader.beagle.gz \
$prefix.chr22.updated.noheader.beagle.gz \
$prefix.chr23.updated.noheader.beagle.gz \
$prefix.chr24.updated.noheader.beagle.gz \
$prefix.chr25.updated.noheader.beagle.gz \
$prefix.chr26.updated.noheader.beagle.gz | gzip > $prefix.wgs.beagle.gz
