text = open("/home/ak/Videos/lang_Trans_NMT/data_cleaning/pmindia.en-ta.en.txt", "r")
text = ''.join([i for i in text]) \
    .replace('&*', ',')
x = open("pmindia.en-ta.en.txt","w")
x.writelines(text)
x.close()
