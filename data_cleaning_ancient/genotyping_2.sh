#!/bin/bash
#SBATCH --account=nn9244k
#SBATCH --time=6:00:00
#SBATCH --job-name=angsd_snpcalling
#SBATCH --cpus-per-task=2
#SBATCH --mem-per-cpu=12G

#set -o errexit

module --quiet purge
module load angsd/0.940-GCC-11.2.0


#filtering bam files

prefix=$1.chr$2
chr=$2
REF=/cluster/projects/nn9244k/databases/herring/ref_genome/Ch_v2.0.2.fasta
nInd=84

#angsd -b $prefix.list -r $chr -ref $REF -out ../Genotyping/$prefix.minmapq20 \
#-uniqueOnly 1 -remove_bads 1 -only_proper_pairs 1 -trim 0 -C 50 \
#-minInd 3 -minMapQ 20 -minQ 20 -setMinDepth 1 -setMaxDepth 30 -doCounts 1 \
#-GL 1 -doGlf 1 -noTrans 1 -nThreads 10

#angsd -glf ../Genotyping/$prefix.glf.gz -ref $REF -fai $REF.fai -nInd $nInd \
#-doMaf 1 -doPost 2 \
#-doMajorMinor 4 \
#-doPlink 2 -doGeno 3 \
#-skipTriallelic \
#-minMaf 0.01 \
#-out ../Genotyping/$prefix.maf0.01

angsd -glf ../Genotyping/$prefix.glf.gz -ref $REF -fai $REF.fai -nInd $nInd \
-r $chr \
-doMaf 1 -doPost 2 \
-doMajorMinor 4 \
-doPlink 2 -doGeno 3 \
-doGlf 2 \
-minMaf 0.01 \
-skipTriallelic \
-out ../Genotyping/$prefix.maf0.01.nopost

#-minMaf 0.01 \
#-postCutoff 0.95 \
#-out ../Genotyping/$prefix.nomaf.nopost

#angsd -b $prefix.list -r $chr -ref $REF -out ../Genotyping/beagle/$prefix \
#-sites ../Genotyping/whole_genome/snp_list.txt -dobcf 1 -GL 1 \
#-doPost 1 -doMajorMinor 3 -doMaf 1
