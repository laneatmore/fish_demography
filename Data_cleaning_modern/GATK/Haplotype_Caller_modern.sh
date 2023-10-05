#!/bin/bash
#SBATCH --account=nn9244k
#SBATCH --time=20:00:00
#SBATCH --job-name=Haplotype_Caller_herring
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=15G

set -o errexit #Make bash exit on any error
set -o nounset #Treat any unset variable as errors

module --quiet purge
module load GATK/4.4.0.0-GCCcore-12.2.0-Java-17

java -version
which java
echo "Initiating GATK on ${1}"

i=$2

#for i in {1..26}; do # for each chromosome in the list
#    {
gatk --java-options "-Xmx8g -DGATK_STACKTRACE_ON_USER_EXCEPTION=true" HaplotypeCaller \
-VS STRICT \
-R /cluster/projects/nn9244k/databases/herring/ref_genome/Ch_v2.0.2.fasta \
-I /cluster/work/users/lanea/new_BAMs/modern/${1}.Her_nu.bam \
-ploidy 2 \
-ERC GVCF \
-L $i \
-O /cluster/work/users/lanea/new_BAMs/all_gVCFs_nu/${1}.$i.g.vcf.gz 2> /cluster/work/users/lanea/new_BAMs/all_gVCFs_nu/Haplotype_caller.${1}.$i.out
#    }; done
#DONE
