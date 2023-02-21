# fish_demography

Files:

gone.sh - script for running gone assuming you are running in the directory structure I have (and is in the tutorial)
Run as: for i in {1..40}; do sbatch gone.sh $POP $i; done

cat_iterations.py - will run gone x number of times and then cat the Ne results and create an aggregated graph which is then copied into the results folder (see gone.sh) 
