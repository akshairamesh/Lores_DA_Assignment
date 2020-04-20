#!/usr/bin/python

import sys,random

if (len(sys.argv) != 8):
	sys.stderr.write("Usage: divide.py srcLang trgLang corpus_dir prefix test/devprefix restsetprefix test/devlines\n")
	sys.exit(1)

srcLang = sys.argv[1]
trgLang = sys.argv[2]
corpusdir = sys.argv[3]
suffix = sys.argv[4]
testsuff = sys.argv[5]
restsuf = sys.argv[6]
testl = int(sys.argv[7])

s_corpus = open(corpusdir+"/"+suffix+"."+srcLang)
t_corpus = open(corpusdir+"/"+suffix+"."+trgLang)

srcTestFile = open(corpusdir+"/"+testsuff+"."+srcLang, "w")
trgTestFile = open(corpusdir+"/"+testsuff+"."+trgLang, "w")
srcTrainFile = open(corpusdir+"/"+restsuf + "."+srcLang, "w")
trgTrainFile = open(corpusdir+"/"+restsuf + "."+trgLang, "w")

#get the length category of each source line
count = 0
for s_line in s_corpus:
	count += 1
print(" total sentences count: {}".format(str(count)))

testLines = set()

while (len(testLines) < testl):
	testLines.add(random.randint(1,count))

available = set(range(1,count))
available = available.difference(testLines)

#while (len(devLines) < devl):
#	index = random.randint(1,count)
#	if not index in available:
#                continue
#        devLines.add(index)
#	available.remove(index)

idx = 1
s_corpus.seek(0)
while idx<=count:
	s_sent = s_corpus.readline()
	t_sent = t_corpus.readline()
#	if idx in devLines:
#		srcDevFile.write(s_sent)
#		trgDevFile.write(t_sent)
	if idx in testLines:
		srcTestFile.write(s_sent)
		trgTestFile.write(t_sent)
	else:
		srcTrainFile.write(s_sent)
		trgTrainFile.write(t_sent)
	idx+=1
