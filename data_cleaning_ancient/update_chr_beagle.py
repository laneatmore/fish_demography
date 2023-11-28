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

def read_beagle():
		beagle = pd.read_csv(prefix + '.beagle.gz', compression = 'gzip', 
			delim_whitespace = True, 
			header = 0, low_memory=False)
		
		#first split the position column	
		beagle['chr'] = beagle['marker'].str.split('_').map(lambda x: x[0])
		beagle['id'] = beagle['marker'].str.split('_').map(lambda x: x[1])

		#then rename the position column to the true chromosome
		beagle['chr'] = chrom

		#now create a new position column to output updated IDs
		beagle['new_marker'] = beagle[['chr','id']].agg('_'.join, axis = 1)

		#make an updated chromosome file to input into plink
		beagle['marker'] = beagle['new_marker']
		beagle = beagle.drop(['new_marker','chr','id'], axis = 1)

		beagle.to_csv(prefix + '.updated.beagle.gz', compression = 'gzip',
			sep = '\t', header = True, index = False)

read_beagle()
	