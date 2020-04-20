

def parser_executor(FILE_NAME1):
	
	with open(FILE_NAME1,'r') as fh:
		iter_var = line_var = 0
		empty_line_count = 0
		arr = [] 
		for line in fh:
			line_var = line_var + 1        
			if line.split() == []:
				arr.append(line_var)
				empty_line_count = empty_line_count + 1
		            
	print('Empty Line Count : ' , empty_line_count,end='\n')
	return arr



arr1 = parser_executor('jw300.ta')

arr2 = parser_executor('jw300.hi')

#intersection is null.
joined_list = arr1 + arr2
joined_list.sort()
justcount = 0
#for i in range(len(joined_list)):
#	if joined_list[i] in arr1:
		


print(arr2)





