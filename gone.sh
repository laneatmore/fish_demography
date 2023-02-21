#!/bin/bash
#SBATCH --account=nn9244k
#SBATCH --time=06:00:00
#SBATCH --job-name=gone
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=8G

#Call this script with:
#for f in $(ls *.bam); do sbatch HaplotypeCaller_new.sh $f; done

#if you need long time
# --partition=long

#If you need hugemem...
# --partition=hugemem

#set -o errexit #Make bash exit on any error
#set -o nounset #Treat any unset variable as errors

module --quiet purge
module load Anaconda3/2019.03

export PS1=\$

source ${EBROOTANACONDA3}/etc/profile.d/conda.sh

conda deactivate &>/dev/null
conda activate /cluster/projects/nn9244k/python3

#Set up the job environment

prefix=$1
rep=$2

mkdir -p $prefix

cd $prefix
scp ../cat_results.py .

mkdir -p results

mkdir -p $prefix.$rep

cd $prefix.$rep

scp /cluster/work/users/lanea/PLINK/$prefix.ped .
scp /cluster/work/users/lanea/PLINK/$prefix.map .
scp /cluster/work/users/lanea/GONE/Linux/script_GONE.sh .
scp -r /cluster/work/users/lanea/GONE/Linux/PROGRAMMES .
scp -r /cluster/work/users/lanea/GONE/CODES_LINUX/INPUT_PARAMETERS_FILE .

chmod +x PROGRAMMES/*

mv $prefix.ped $prefix.$rep.ped
mv $prefix.map $prefix.$rep.map

bash script_GONE.sh $prefix.$rep

mv Output_Ne_$prefix.$rep ../results

python cat_results.py $prefix

