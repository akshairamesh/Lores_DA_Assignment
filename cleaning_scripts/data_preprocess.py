# The path to the local git repo for Indic NLP library
INDIC_NLP_LIB_HOME=r"/home/ak/Videos/lang_Trans_NMT/data_cleaning/indic_library/indicnlp"
# The path to the local git repo for Indic NLP Resources
INDIC_NLP_RESOURCES=r"/home/ak/Videos/lang_Trans_NMT/data_cleaning/indic_nlp_resources"
import sys
sys.path.append(r'{}\src'.format(INDIC_NLP_LIB_HOME))
from indicnlp import common
common.set_resources_path(INDIC_NLP_RESOURCES)
from indicnlp import loader
loader.load()
from indicnlp.normalize.indic_normalize import IndicNormalizerFactory
from indicnlp.morph import unsupervised_morph
from indicnlp import common
from indicnlp.tokenize import indic_tokenize
import argparse

#normalize
def normalize(ip_file_path,op_file_path,ln):
    with open(ip_file_path,'r') as f:
        with open(op_file_path,"w") as text_file:
            for line in f:
                remove_nuktas=False
                factory=IndicNormalizerFactory()
                normalizer=factory.get_normalizer(ln)
                output_text=normalizer.normalize(line)
                text_file.write(output_text)

#word segmentation
def segmentize(ip_file_path,op_file_path,ln):
    analyzer=unsupervised_morph.UnsupervisedMorphAnalyzer(ln)
    with open(ip_file_path,'r') as f:
        with open(op_file_path,"w") as text_file:
            for line in f:
                analyzes_tokens=analyzer.morph_analyze_document(line.split(' '))
                text_file.write(' '.join(analyzes_tokens))


#to_lower
def tolower(ip_file_path,op_file_path):
    with open(ip_file_path,'r') as f:
        with open(op_file_path,"w") as text_file:
            for line in f:
                line = line.lower()
                text_file.write(line)

#tokenize
def tokenize(ip_file_path,op_file_path):
    with open(ip_file_path,'r') as f:
        with open(op_file_path,"w") as text_file:
            for line in f:
                result_arr = indic_tokenize.trivial_tokenize(line)
                tokenized_sentence = ' '.join(result_arr)
                text_file.write(tokenized_sentence)

argparser = argparse.ArgumentParser()
argparser.add_argument('-s', '--srcLang', required=True, help='Short version of the source language')
argparser.add_argument('-t', '--trgLang', required=False, help='Short version of the target language')
argparser.add_argument('-sc', '--srcc', required=True, help='source language corpus.')
argparser.add_argument('-tc', '--trgc', required=False, help='target language corpus.')
argparser.add_argument('-fp', '--folderpath', required=False, help='percentage of confirmation')
argparser.add_argument('-pref', '--prefix', required=True, help='Corpus output file: Prefix')
args = argparser.parse_args()

#automate the process
ip_file_path = args.folderpath + args.srcc
op_file_path = args.folderpath + args.prefix + args.srcc
inter_med_file1 = args.folderpath + 'data-middle1'
inter_med_file2 = args.folderpath + 'data-middle2'
normalize(ip_file_path,inter_med_file1,args.srcLang)
#segmentize(op_file_path,inter_med_file,ln)
tokenize(inter_med_file1,inter_med_file2)
tolower(inter_med_file2, op_file_path)


ip_file_path = args.folderpath + args.trgc
op_file_path = args.folderpath + args.prefix + args.trgc
inter_med_file1 = args.folderpath + 'data-middle1'
inter_med_file2 = args.folderpath + 'data-middle2'
normalize(ip_file_path,inter_med_file1,args.trgLang)
#segmentize(op_file_path,inter_med_file,ln)
tokenize(inter_med_file1,inter_med_file2)
tolower(inter_med_file2, op_file_path)
