#!/bin/bash
#SBATCH --account=nn9244k
#SBATCH --time=14:00:00
#SBATCH --job-name=angsd_snpcalling
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=12G

#set -o errexit

module --quiet purge
module load angsd/0.940-GCC-11.2.0


#filtering bam files

prefix=$1.chr$2
chr=$2
REF=/cluster/projects/nn9244k/databases/herring/ref_genome/Ch_v2.0.2.fasta
nInd=84

#now we want the genotype likelihoods

angsd -b $prefix.list -r $chr -ref $REF -out ../Genotyping/$prefix.MQ20.post0.95 \
-uniqueOnly 1 -remove_bads 1 -only_proper_pairs 1 -trim 0 -C 50 -baq 1 \
-minMapQ 20 -minQ 20 -minInd 3 -setMinDepth 3 \
-setMaxDepth 200 -doCounts 1 \
-GL 1 -doGlf 2 -doMajorMinor 2 -rmTrans 1 \
-doGeno 2 -doPost 2 \
-skipTriallelic 1 \
-postCutoff 0.95 \
-nThreads 10


angsd -b $prefix.list -r $chr -ref $REF -out ../Genotyping/$prefix.MQ20.post0.95.maf0.01 \
-uniqueOnly 1 -remove_bads 1 -only_proper_pairs 1 -trim 0 -C 50 -baq 1 \
-minMapQ 20 -minQ 20 -minInd 3 -setMinDepth 3 \
-setMaxDepth 200 -doCounts 1 \
-GL 1 -doGlf 2 -doMajorMinor 2 -rmTrans 1 \
-doGeno 2 -doPost 2 \
-skipTriallelic 1 \
-postCutoff 0.95 \
-doMaf 1 -minMaf 0.01 \
-nThreads 10
