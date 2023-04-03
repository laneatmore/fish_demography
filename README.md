# fish_demography

Files:

gone.sh - script for running gone assuming you are running in the directory structure I have (and is in the tutorial)
Run as: for i in {1..40}; do sbatch gone.sh $POP $i; done

cat_results.py - will run gone x number of times and then cat the Ne results and create an aggregated graph which is then copied into the results folder (see gone.sh) 

pairwise_fst.py - will wrap PLINK to run pairwise Fst analysis on whatever populations are specified in the fam file. Run with the bfile prefix as input and get a pairwise Fst matrix and heatmap as output. --Required python packages: pandas_plink. 
