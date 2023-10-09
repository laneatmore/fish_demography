#!/bin/bash/
#SBATCH --account=nn9244k
#SBATCH --time=0:30:00
#SBATCH --job-name=snp_list
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=2G

#check how long this will take on your data
#the cod run settings were really high!

#set -o errexit


module --quiet purge
module load angsd/0.940-GCC-11.2.0
module load Anaconda3/2022.10

#export PS1=\$

#source ${EBROOTANACONDA3}/etc/profile.d/conda.sh

#conda deactivate &>/dev/null

echo "activating conda"
conda activate /cluster/projects/nn9244k/python3

for chr in {1..\26}; do gunzip -c all.chr$chr.maf0.01.post0.95.mafs.gz | \
cut -f 1,2,3,4 | tail -n +1 > \
all.chr$chr.maf0.01.post0.95.snp_list.txt; done
 
python replace_chr.py

echo "indexing whole genome list"
angsd sites index snp_list.txt

for chr in {1..26}; do angsd sites index chr$chr.snp_list.txt; done

wc -l snp_list.txt
