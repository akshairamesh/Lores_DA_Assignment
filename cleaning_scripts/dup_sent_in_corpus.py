
import sys
#print(f.read())

def check():
	file1 = sys.argv[1]
	file2 = sys.argv[2]
	f = open(file1)
	test_set_hi = open(file2)
	test_hi = test_set_hi.readlines()
	train_hi = f.readlines()
	same = set(test_hi).intersection(train_hi)
	print(len(same))
check()
