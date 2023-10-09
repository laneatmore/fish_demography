#!/bin/bash
#SBATCH --account=nn9244k
#SBATCH --time=3:00:00
#SBATCH --job-name=angsd_snpcalling
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=8G

#set -o errexit

module --quiet purge
module load angsd/0.940-GCC-11.2.0


#filtering bam files

prefix=$1
REF=/cluster/projects/nn9244k/databases/herring/ref_genome/Ch_v2.0.2.fasta
nInd=86

angsd -b $prefix.list -ref $REF -sites maf0.01.post0.95.snp_list.txt \
-out ../Genotyping/whole_genome/$prefix.maf0.01.post0.95 \
-doCounts 1 \
-GL 1 -doGlf 1 -nThreads 10

#angsd -glf ../Genotyping/$prefix.glf.gz -ref $REF -fai $REF.fai -nInd $nInd \
#-doMaf 1 -doPost 2 \
#-doMajorMinor 4 \
#-doPlink 2 -doGeno 3 \
#-skipTriallelic \
#-minMaf 0.01 \
#-out ../Genotyping/$prefix.maf0.01

angsd -glf ../Genotyping/whole_genome/$prefix.maf0.01.post0.95.glf.gz -ref $REF -fai $REF.fai -nInd $nInd \
-doMaf 1 -sites maf0.01.post0.95.snp_list.txt \
-doMajorMinor 4 \
-doPlink 2 -doGeno 3 \
-doPost 1 \
-out ../Genotyping/$prefix.maf0.01.post0.95
