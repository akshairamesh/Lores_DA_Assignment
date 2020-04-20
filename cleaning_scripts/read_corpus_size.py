import argparse
#get the length category of each source line
argparser = argparse.ArgumentParser()
argparser.add_argument('-s', '--srcLang', required=True, help='Short version of the source language')
argparser.add_argument('-t', '--trgLang', required=True, help='Short version of the target language')
args = argparser.parse_args()

count = 0
s_corpus = open(args.srcLang)
t_corpus = open(args.trgLang)
for s_line in s_corpus:
	count += 1
print(" total sentences count: {}".format(str(count)))
count = 0
for t_line in t_corpus:
	count +=1
print(" total sentences count: {}".format(str(count)))
