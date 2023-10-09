#!/bin/bash
#SBATCH --account=nn9244k
#SBATCH --time=6:00:00
#SBATCH --job-name=angsd_sfs
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=8G

module --quiet purge
module load angsd/0.940-GCC-11.2.0

prefix=$1
REF=/cluster/projects/nn9244k/databases/herring/ref_genome/Ch_v2.0.2
nInd=86
ANC=/cluster/projects/nn9244k/databases/herring/ref_genome/GCA_003604335.1

#ANCESTOR FILE GENERATED USING NCBI 

#first generate 1d sfs
for POP in $(less $prefix.$pop.list): \
do; \
	echo $POP |
	angsd -b $prefix.$pop.list -ref $REF.fasta -anc $ANC.fasta -out results/$prefix.$pop \
	-uniqueOnly 1 -remove_bads 1 -only_proper_pairs 1 -trim 0 -C 50 \
    -minMapQ 20 -minQ 20 -minInd 5 -setMinDepth 5 -setMaxDepth 60 -doCounts 1 \
    -GL 1 -doSaf 1; \
done

#next look at sfs using realsfs


for POP in $(less $prefix.$pop.list); \
do ; \
	echo $POP | \
	angsd -b $prefix.$pop.list -ref $REF.fasta -anc $REF.fasta -out results/$prefix.$pop.folded \
	-uniqueOnly 1 -remove_bads 1 -only_proper_pairs 1 -trim 0 -C 50 \
    -minMapQ 20 -minQ 20 -minInd 5 -setMinDepth 5 -setMaxDepth 60 -doCounts 1 \
    -GL 1 -doSaf 1; \
done
