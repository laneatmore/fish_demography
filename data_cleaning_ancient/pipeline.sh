#first call snps by chr (after sorting out appropriate filters!) with angsd

for chr in {1..26}; do sbatch genotyping_by_chr_angsd.sh {bam list prefix} $chr; done

#generate snp lists and then cat them into a whole genome snp list

sbatch generate_snp_lists.sh #requires replace_chr.py, call from directory with output angsd files

#generate whole genome glf and tped/tmap files with the whole genome snp list

sbatch wgs_genotyping.sh all

#convert from tped/tmap to bed/bim/fam

plink --tfile all.maf0.01.post0.95 --make-bed --chr-set 26 --double-id --out all.maf0.01.post0.95

#then replace the fam file with the properly annotated populations from harddrive 

#ready to go!
