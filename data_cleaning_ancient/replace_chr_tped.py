#!/usr/bin/env python3

import os
import sys
import pandas as pd

pd.set_option('display.max_columns', None)
pd.set_option('display.max_rows', None)
pd.set_option('display.width', None)
pd.set_option('display.max_colwidth', None)

prefix=str(sys.argv[1])
chrom=str(sys.argv[2])

def read_tped():
	tped = pd.read_csv(prefix + '.tped', delim_whitespace = True, 
		header = None, low_memory=False)

	#first split the position column	
	tped['chr'] = tped[1].str.split('_').map(lambda x: x[0])
	tped['pos'] = tped[1].str.split('_').map(lambda x: x[1])

	#then rename the position column to the true chromosome
	tped['chr'] = chrom

	#now create a new position column to output updated IDs
	tped['position'] = tped[['chr','pos']].agg('_'.join, axis = 1)

	#make an updated chromosome file to input into plink
	update_chrom = tped[['chr', 1]]

	update_chrom.to_csv(prefix + '.updated.chr.txt', sep = '\t',
		header = False, index = False)
	
	#Now make an updated ID file to rename all the variants
	update_snps = tped[[1,'position']]
	
	update_snps.to_csv(prefix + 'updated.snps.txt', sep = '\t',
		header = False, index = False)
	
read_tped()