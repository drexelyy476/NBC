#! /usr/bin/env python
# _*_ coding: utf-8 _*_
import os
import sys

filename = "null"
num_files = 0
ID = 1
inputPath = sys.argv[1]
print(inputPath)
output_PATH = sys.argv[2] + "/folder_" + str(ID) + "/testset/"

def eachfile(input_PATH):
	global ID
	global output_PATH
	global num_files
	filenames = os.listdir(input_PATH)
	for filename in filenames:
		domain = os.path.abspath(input_PATH)
		filename = os.path.join(domain,filename)
		print(filename)
		if os.path.isdir(filename):
			eachfile(filename)
			continue
		if filename.split('.')[1] == "fa":
			print("here is a fasta file" + filename)
			f = open(filename,'r')
			for line in f:
				title=""
				# print(line)
				if line[0] == '>':
					isExists = os.path.exists(output_PATH)
					title=line
					if not isExists:
						os.mkdir(output_PATH)
						print("create a folder in : " + output_PATH)
					#get the file name
					result = line.split('\n')
					print(result)
					filename =  output_PATH + result[0][1:] + ".fasta"
					file = open(filename,'w')
					file.write(title)
					num_files += 1
					print(num_files)
					#when 1 million file under a folder, create a new folder
					if num_files == 100000:
						ID += 1
						output_PATH = sys.argv[2] + "/folder_" + str(ID) + "/testset/"
						num_files = 0;
				else:
					file = open(filename,'a')
					file.write(line)
			f.close()

eachfile(inputPath)
print("Done")
