#!/bin/bash
#SBATCH --account=nn9244k
#SBATCH --time=03:00:00
#SBATCH --job-name=angsdLD
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=8G

module --quiet purge
module load angsd/0.940-GCC-11.2.0

#first need to get a positions file from mafs file

zcat all.maf0.01.post0.95.mafs.gz | cut -f1,2 | sed 's/:/_/g' | sed 1d | gzip > all.maf0.01.post0.95.ps.gz

#now run ngsLD
prefix=$1
nInd=86
nSites=263594

mkdir -p ngsLD

$NGLSD/ngsLD \
--geno $prefix.maf0.01.post0.95.geno.gz \
--pos $prefix.maf0.01.post0.95.pos.gz \
--probs \
--n_ind $nInd \
--n_sites $nSites \
--max_kb_dist 0 \
--n_threads 5 \
--out ngsLD/$prefix.maf0.01.post0.95.ld
