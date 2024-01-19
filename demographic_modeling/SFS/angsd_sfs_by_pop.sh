#!/bin/bash
#SBATCH --account=nn9244k
#SBATCH --time=20:00:00
#SBATCH --job-name=angsd_sfs
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=20G

set -o errexit

module --quiet purge
module load angsd/0.940-GCC-11.2.0

prefix=$1
REF=/cluster/projects/nn9244k/databases/herring/ref_genome/Ch_v2.0.2
nInd=`cat $prefix.list | wc -l`

echo $prefix

angsd -b $prefix.list -ref $REF.fasta -anc $REF.fasta -out results/$prefix.folded \
-uniqueOnly 1 -remove_bads 1 -only_proper_pairs 1 -trim 0 -C 50 \
-minMapQ 20 -minQ 20 -setMinDepth 5 -setMaxDepth 60 -doCounts 1 \
-doMajorMinor 2 -rmTrans 1 -GL 1 -doSaf 1

realSFS results/$prefix.folded.saf.idx -fold 1 -P 4 > results/$prefix.folded.sfs

realSFS results/$prefix.folded.saf.idx -bootstrap 10 2> /dev/null ? results/$prefix.folded.boots.sfs
cat results/$prefix.folded.boots.sfs
