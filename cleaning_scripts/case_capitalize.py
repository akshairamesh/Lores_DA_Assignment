def tolower(ip_file_path,op_file_path): 
    with open(ip_file_path,'r') as f:
        with open(op_file_path,"w") as text_file:
            for line in f:
                line = line.lower()
                text_file.write(line)


tolower('/home/ak/Videos/lang_Trans_NMT/data_cleaning/data/Ubuntu/Ubuntu.en-ta.en','/home/ak/Videos/lang_Trans_NMT/data_cleaning/data/Ubuntu/Ubuntu.op.en')

tolower('/home/ak/Videos/lang_Trans_NMT/data_cleaning/data/Ubuntu/Ubuntu.en-ta.ta','/home/ak/Videos/lang_Trans_NMT/data_cleaning/data/Ubuntu/Ubuntu.op.ta')
