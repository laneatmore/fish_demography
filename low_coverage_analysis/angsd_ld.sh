#!/bin/bash
#SBATCH --account=nn9244k
#SBATCH --time=03:00:00
#SBATCH --job-name=angsdLD
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=8G

module --quiet purge
module load angsd/0.940-GCC-11.2.0
module load GSL/2.7-GCC-11.2.0

#first need to get a positions file from mafs file

for chr in {1..26}; do zcat all.miss0.7.chr$chr.mafs.gz | cut -f1,2 | sed 's/:/_/g' | sed 1d | gzip > \
file_conversion/all.miss0.7.chr$chr.prepped.mafs.gz ; done

cd file_conversion
zcat all.miss0.7.chr1.prepped.mafs.gz all.miss0.7.chr2.prepped.mafs.gz all.miss0.7.chr3.prepped.mafs.gz \
all.miss0.7.chr4.prepped.mafs.gz all.miss0.7.chr5.prepped.mafs.gz \
all.miss0.7.chr6.prepped.mafs.gz all.miss0.7.chr7.prepped.mafs.gz all.miss0.7.chr8.prepped.mafs.gz \
all.miss0.7.chr9.prepped.mafs.gz all.miss0.7.chr10.prepped.mafs.gz \
all.miss0.7.chr11.prepped.mafs.gz all.miss0.7.chr12.prepped.mafs.gz all.miss0.7.chr13.prepped.mafs.gz \
all.miss0.7.chr14.prepped.mafs.gz all.miss0.7.chr15.prepped.mafs.gz \
all.miss0.7.chr16.prepped.mafs.gz all.miss0.7.chr17.prepped.mafs.gz all.miss0.7.chr18.prepped.mafs.gz \
all.miss0.7.chr19.prepped.mafs.gz all.miss0.7.chr20.prepped.mafs.gz \
all.miss0.7.chr21.prepped.mafs.gz all.miss0.7.chr22.prepped.mafs.gz all.miss0.7.chr23.prepped.mafs.gz \
all.miss0.7.chr24.prepped.mafs.gz all.miss0.7.chr25.prepped.mafs.gz \
all.miss0.7.chr26.prepped.mafs.gz | gzip > all.miss0.7.pos.gz

scp all.miss0.7.pos.gz ../

cd ../

#now cat all the geno files together
zcat all.miss0.7.chr1.geno.gz all.miss0.7.chr2.geno.gz all.miss0.7.chr3.geno.gz all.miss0.7.chr4.geno.gz all.miss0.7.chr5.geno.gz \
all.miss0.7.chr6.geno.gz all.miss0.7.chr7.geno.gz all.miss0.7.chr8.geno.gz all.miss0.7.chr9.geno.gz all.miss0.7.chr10.geno.gz \
all.miss0.7.chr11.geno.gz all.miss0.7.chr12.geno.gz all.miss0.7.chr13.geno.gz all.miss0.7.chr14.geno.gz all.miss0.7.chr15.geno.gz \
all.miss0.7.chr16.geno.gz all.miss0.7.chr17.geno.gz all.miss0.7.chr18.geno.gz all.miss0.7.chr19.geno.gz all.miss0.7.chr20.geno.gz \
all.miss0.7.chr21.geno.gz all.miss0.7.chr22.geno.gz all.miss0.7.chr23.geno.gz all.miss0.7.chr24.geno.gz all.miss0.7.chr25.geno.gz \
all.miss0.7.chr26.geno.gz | gzip > all.miss0.7.geno.gz

zcat all.miss0.7.chr1.glf.gz all.miss0.7.chr2.glf.gz all.miss0.7.chr3.glf.gz all.miss0.7.chr4.glf.gz all.miss0.7.chr5.glf.gz \
all.miss0.7.chr6.glf.gz all.miss0.7.chr7.glf.gz all.miss0.7.chr8.glf.gz all.miss0.7.chr9.glf.gz all.miss0.7.chr10.glf.gz \
all.miss0.7.chr11.glf.gz all.miss0.7.chr12.glf.gz all.miss0.7.chr13.glf.gz all.miss0.7.chr14.glf.gz all.miss0.7.chr15.glf.gz \
all.miss0.7.chr16.glf.gz all.miss0.7.chr17.glf.gz all.miss0.7.chr18.glf.gz all.miss0.7.chr19.glf.gz all.miss0.7.chr20.glf.gz \
all.miss0.7.chr21.glf.gz all.miss0.7.chr22.glf.gz all.miss0.7.chr23.glf.gz all.miss0.7.chr24.glf.gz all.miss0.7.chr25.glf.gz \
all.miss0.7.chr26.glf.gz | gzip > all.miss0.7.glf.gz

#now run ngsLD
prefix=$1
nInd=84
nSites=271265

mkdir -p ngsLD

$NGLSD/ngsLD \
--geno $prefix.glf.gz \
--pos $prefix.pos.gz \
--probs --log-scale \
--n_ind $nInd \
--n_sites $nSites \
--max_kb_dist 0 \
--n_threads 5 \
--out ngsLD/$prefix.ld
