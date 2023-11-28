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

angsd -b $prefix.list -r $chr -ref $REF -out ../Genotyping/$prefix \
-uniqueOnly 1 -remove_bads 1 -only_proper_pairs 1 -trim 0 -C 50 -baq 1 \
-minMapQ 30 -minQ 20 -minInd 3 -setMinDepth 3 -noTrans 1 \
-setMaxDepth 30 -doCounts 1 \
-GL 1 -doGlf 1 -nThreads 10

#mv ../Genotyping/$prefix.arg ../Genotyping/$prefix.glf_creation.arg
#play around with the cut off value to see what's right for the data
#to determine which GL to keep

#for c in 0.5 0.6 0.7 0.8 0.9 0.95; do \
#angsd -glf ../Genotyping/$prefix.glf.gz -r $chr -ref $REF -fai $REF.fai -nInd $nInd -out ../Genotyping/$prefix.95GL \
#-doMajorMinor 4 -doGeno 2 -doPost 2 -doMaf 1 -postCutoff 0.95 -minMaf 0.01


#angsd -glf ../Genotyping/$prefix.glf.gz -r $chr -ref $REF -fai $REF.fai -nInd $nInd -out ../Genotyping/$prefix.post0.95 \
#-doMajorMinor 4 -doGeno 3 -doPost 2 -doMaf 1 -postCutoff 0.95 -skipTriallelic 1 -doGlf 2 


#angsd -glf ../Genotyping/$prefix.glf.gz -ref $REF -fai $REF.fai -nInd $nInd -out ../Genotyping/$prefix.pval1e6.NOMAF \
#-doMajorMinor 4 -doGeno 2 -doPost 2 -doMaf 1 -SNP_pval 1e-6 -skipTriallelic 1 -doPlink 2 -doGlf 2

#$c; done

