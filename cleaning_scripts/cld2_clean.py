import pycld2 as cld2
import argparse

argparser = argparse.ArgumentParser()
argparser.add_argument('-s', '--srcLang', required=True, help='Short version of the source language')
argparser.add_argument('-t', '--trgLang', required=False, help='Short version of the target language')
argparser.add_argument('-sc', '--srcc', required=True, help='source language corpus.')
argparser.add_argument('-tc', '--trgc', required=False, help='target language corpus.')
argparser.add_argument('-fp','--folderpath',required = True, help='corpus folder path.')
argparser.add_argument('-pref', '--prefix', required=True, help='Corpus output file: Prefix')
argparser.add_argument('-confirm', '--confirm', required=False, help='percentage of confirmation')
args = argparser.parse_args()

def num_of_sentences(file_path):
    count = 0
    file = open(file_path,'r')
    for line in file :
        count = count + 1
    return count

def cld_clean():
    ip_src_file  = open(args.folderpath + args.srcc,'r')
    op_src_file = open(args.folderpath + args.prefix + args.srcc,"w")
    ip_trg_file = open(args.folderpath + args.trgc,'r')
    op_trg_file = open(args.folderpath + args.prefix + args.trgc,"w")

    src_content = ip_src_file.readlines()
    #src_content = src_content.encode('utf8')
    trg_content = ip_trg_file.readlines()
    #trg_content = trg_content.encode('utf8')
    for line in range(0,len(src_content)):
        isReliable, textBytesFound, details1 = cld2.detect(src_content[line])
        src_flag = trg_flag = False
        if( details1[0][2] >= int(args.confirm)  and details1[0][1] == args.srcLang):
            src_flag = True
        isReliable, textBytesFound, details2 = cld2.detect(trg_content[line])
        if(details2[0][2] >= int(args.confirm) and details2[0][1] == args.trgLang):
            trg_flag = True
        if(src_flag == trg_flag):
            #print('{} {} {}'.format(details1[0][2],details2[0][2],line))
            op_src_file.write(src_content[line])
            op_trg_file.write(trg_content[line])
#print(cld2.detect(s))

print('sentences before cld :',num_of_sentences(args.folderpath + args.srcc))
cld_clean()
print('sentences after cld :',num_of_sentences(args.folderpath + args.prefix + args.srcc))
#print('  detected: %s' % detectedLangName)
#print('  reliable: %s' % (isReliable != 0))
#print('  textBytes: %s' % textBytesFound)
#print('  details: %s' % str(details))
