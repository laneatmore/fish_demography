#!/usr/bin/python3

import pandas as pd
import sys
import os

chr = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26]

snp_lists = {}

for i in chr:
	snp_list = pd.read_csv('all.chr' + str(i) + '.maf0.01.post0.95.snp_list.txt', delim_whitespace = True)
	snp_list['chromo'] = i
	print(snp_list.head())
	snp_lists[i] = snp_list
	snp_list.to_csv('chr' + str(i) + '.snp_list.txt', sep = '\t', index = False, header = False)

all_snps = pd.concat(snp_lists.values())
print(all_snps.head())
print(all_snps.tail())

all_snps.to_csv('snp_list.txt', sep = '\t', index = False, header = False)
