#after converting data from VCF to PLINK, prune for LD and then randomly subset for 50k SNPs

plink --bfile smartpca/binsa --allow-extra-chr --chr-set 26 --double-id --indep-pairwise 50 5 0.2 \
--set-missing-var-ids @:# --out smartpca/binsa

plink --bfile smartpca/binsa --allow-extra-chr --chr-set 26 --double-id --set-missing-var-ids @:# \
--extract smartpca/binsa.prune.in --make-bed --out smartpca/binsa.pruned

plink --bfile smartpca/binsa.pruned --recode --chr-set 26 --out smartpca/binsa.pruned

cut -f 2 smartpca/binsa.pruned.map > smartpca/snps.map

shuf -n 50000 smartpca/snps.map > smartpca/snps.subset.map

plink --bfile smartpca/binsa.pruned --extract snps.subset.map --make-bed \
--chr-set 26 --out smartpca/binsa.pruned.50k

#Then convert to structure format with PLINK

plink --bfile smartpca/binsa.pruned.50k --recode structure --chr-set 26 --out smartpca/binsa.pruned.50k
