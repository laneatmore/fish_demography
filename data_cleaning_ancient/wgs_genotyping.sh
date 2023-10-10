#!/bin/bash
#SBATCH --account=nn9244k
#SBATCH --time=3:00:00
#SBATCH --job-name=angsd_snpcalling
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=8G

#set -o errexit

#!/bin/bash
#SBATCH --account=nn9244k
#SBATCH --time=6:00:00
#SBATCH --job-name=angsd_snpcalling
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=10G

#set -o errexit

module --quiet purge
module load angsd/0.940-GCC-11.2.0
module load Anaconda3/2022.10

#filtering bam files

prefix=$1.chr$2
chr=$2
REF=/cluster/projects/nn9244k/databases/herring/ref_genome/Ch_v2.0.2.fasta
nInd=86

angsd -b $prefix.list -r $chr -ref $REF -out ../Genotyping/renamed_chr/$prefix \
-sites ../Genotyping/whole_genome/chr$chr.snp_list.txt \
-doCounts 1 \
-GL 1 -doGlf 4 \
-doPlink 2 \
-doMajorMinor 4 \
-doMaf 1 \
-doPost 2 \
-doGeno 3 \
-nThreads 10

#then zcat all the glf files, combine the chromosomes in plink etc
