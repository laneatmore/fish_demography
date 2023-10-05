#!/bin/bash
#SBATCH --job-name=Filter
#SBATCH --account=nn9244k
#SBATCH --time=10:00:00
#SBATCH --mem-per-cpu=5G
#SBATCH --ntasks-per-node=1

module purge
module load BCFtools/1.15.1-GCC-11.3.0

prefix=$1


bcftools filter -i 'FS<60.0 && SOR<4 && MQ>30.0 && QD > 2.0 && INFO/DP<415140' \
--SnpGap 10 -O z \
-o ${prefix}_HF.vcf.gz ${prefix}.raw.vcf.gz &> ${prefix}_HF.vcf.out

module load HTSlib/1.15.1-GCC-11.3.0
tabix ${prefix}_HF.vcf.gz
