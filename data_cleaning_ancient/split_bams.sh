#!/bin/bash
#SBATCH --account=nn9244k
#SBATCH --time=02:00:00
#SBATCH --job-name=split_bams
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4G

module --quiet purge
module load SAMtools/1.17-GCC-12.2.0

prefix=$1

echo "running on ${prefix}"

#for i in $(less $prefix.list); \
for chr in {1..26}; \
do samtools view \
-h -b bam_files/$prefix.Her_nu.bam $chr > $prefix.chr$chr.bam; done #; done

#for i in $(ls *.bam); do samtools index $i; done

#prefix=$1

for chr in {1..26}; do \
#for i in $(less $prefix.list); \
samtools index by_chr/$prefix.chr$chr.bam; done
