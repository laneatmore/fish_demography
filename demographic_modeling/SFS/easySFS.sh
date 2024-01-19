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


###after running, need to combine chromosomes for subsequent analysis

#run per pop
for chr in {1..26}; do cat chr${chr}_output/fastsimcoal2/NorthSea_MAFpop0.obs | head -3 | tail -1 >> tmp; done
for col in {1..6}; do cut -d ' ' -f${col} tmp | awk '{sum+=$1;} END{print sum;}' >> tmp2; done
cat tmp2 | tr '\n' ' ' > NorthSea.sfs

for chr in {1..26}; do cat chr${chr}_output/fastsimcoal2/CelticSea_MAFpop0.obs | head -3 | tail -1 >> tmp; done
for col in {1..6}; do cut -d ' ' -f${col} tmp | awk '{sum+=$1;} END{print sum;}' >> tmp2; done
cat tmp2 | tr '\n' ' ' > CelticSea.sfs

for chr in {1..26}; do cat chr${chr}_output/fastsimcoal2/IsleOfMan_MAFpop0.obs | head -3 | tail -1 >> tmp; done
for col in {1..6}; do cut -d ' ' -f${col} tmp | awk '{sum+=$1;} END{print sum;}' >> tmp2; done
cat tmp2 | tr '\n' ' ' > IsleOfMan.sfs

for chr in {1..26}; do cat chr${chr}_output/fastsimcoal2/Downs_MAFpop0.obs | head -3 | tail -1 >> tmp; done
for col in {1..6}; do cut -d ' ' -f${col} tmp | awk '{sum+=$1;} END{print sum;}' >> tmp2; done
cat tmp2 | tr '\n' ' ' > Downs.sfs


for chr in {1..26}; do cat chr${chr}_output/fastsimcoal2/Binsa_MAFpop0.obs | head -3 | tail -1 >> tmp; done
for col in {1..6}; do cut -d ' ' -f${col} tmp | awk '{sum+=$1;} END{print sum;}' >> tmp2; done
cat tmp2 | tr '\n' ' ' > Binsa.sfs
