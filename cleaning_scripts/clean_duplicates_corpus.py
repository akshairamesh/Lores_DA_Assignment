import argparse
#remove duplicates from the corpus
argparser = argparse.ArgumentParser()
argparser.add_argument('-s', '--srcLang', required=True, help='Short version of the source language')
argparser.add_argument('-so', '--srcOut', required=True, help='Short version of the source output')
argparser.add_argument('-t', '--trgLang', required=False, help='Short version of the target language')
argparser.add_argument('-to', '--trgOut', required=False, help='Short version of the target output')
args = argparser.parse_args()
lines_seen = set() # holds lines already seen
outfile = open(args.srcOut, "w")
input_file = open(args.trgLang,"r")
trg_out_file = open(args.trgOut,"w")
trg_lines = input_file.readlines()
#print(trg_lines[1])
count = 0
for line in open(args.srcLang, "r"):
	count = count + 1
	if line not in lines_seen: # not a duplicate
		trg_out_file.write(trg_lines[count-1])
		outfile.write(line)
		lines_seen.add(line)
outfile.close()
trg_out_file.close()
