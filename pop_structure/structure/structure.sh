#!/bin/bash
#SBATCH --account=nn9244k
#SBATCH --time=72:00:00
#SBATCH --job-name=Structure
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=5G
#SBATCH --mail-user=lane.atmore@ibv.uio.no

#C

#if you need long time
# --partition=long

#If you need hugemem...
# --partition=hugemem

#set -o errexit #Make bash exit on any error
#set -o nounset #Treat any unset variable as errors

#Set up the job environment

module --quiet purge
#module load Structure/2.3.4-GCC-7.3.0-2.30

PATH_TO_STRUCTURE=/cluster/home/lanea/console

K=$1
input=$2
out=${3}_${K}
inds=10
loci=50000
rep=$4

#mkdir K$K
#cd K$K

mkdir rep_$rep
cd rep_$rep
scp ../$input .

echo "#define LABEL 1" > mainparams_${K}
echo "#define POPDATA 1" >> mainparams_${K}
echo "#define POPFLAG 0" >> mainparams_${K}
echo "#define MAXPOPS $K" >> mainparams_${K}
echo "#define BURNIN 10000" >> mainparams_${K}
echo "#define NUMREPS 100000" >> mainparams_${K}
echo "#define INFILE $input" >> mainparams_${K}
echo "#define OUTFILE $out" >> mainparams_${K}
echo "#define NUMINDS $inds" >> mainparams_${K}
echo "#define NUMLOCI $4" >> mainparams_${K}
echo "#define PLOIDY 2" >> mainparams_${K}
echo "#define MISSING -9" >> mainparams_${K}
echo "#define ONEROWPERIND 1" >> mainparams_${K}
echo "#define LOCDATA 0" >> mainparams_${K}
echo "#define PHENOTYPE 0" >> mainparams_${K}
echo "#define MARKERNAMES 1" >> mainparams_${K}
echo "#define RECESSIVEALLELES 0" >> mainparams_${K}
echo "#define MAPDISTANCES 1" >> mainparams_${K}
echo '#define EXTRACOLS 0' >> mainparams_${K}

echo "#define NOADMIX 0" > extraparams_${K}
echo "#define LOCPRIOR 1" >> extraparams_${K}
echo "#define FREQSCORR" >> extraparams_${K}
echo "#define FPRIORMEAN" >> extraparams_${K}
echo "#define FPRIORSD" >> extraparams_${K}
echo "#define INFERALPHA 1" >> extraparams_${K}
echo "#define LOCISPOP 1" >> extraparams_${K}
echo "#define COMPUTEPROB 1" >> extraparams_${K}

$PATH_TO_STRUCTURE/structure \
-m mainparams_${K} \
-e extraparams_${K} \
-K $K \
-L $loci \
-N $inds \
-i $input \
-o $out
