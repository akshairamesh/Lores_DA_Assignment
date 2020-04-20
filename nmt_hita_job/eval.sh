#!/bin/bash

pref=spinning-storage/rameshak
opennmt=/home/rameshak/$pref/software/OpenNMT-py
model = model
SL=hi
TL=ta
#we have 4 test sets: kde4, tz, ubuntu, wikimatrix.

tes=corpus/testset_kde4.$SL   
ref=corpus/testset_kde4.$TL     

#nvidia-smi 

evaluation=evaluation

mkdir $evaluation -p

# Decoding (translation)
python3 $opennmt/translate.py -model /home/rameshak/spinning-storage/rameshak/model/lstm_step_5000.pt -src $tes -output $evaluation/pred_kde.txt -replace_unk -verbose

#Evaluation -- measuring bleu
/home/rameshak/$pref/software/scripts/generic/multi-bleu.perl $ref < $evaluation/pred_kde.txt > $evaluation/results_kde4



tes=corpus/testset_tz.$SL   
ref=corpus/testset_tz.$TL     

#decoding (Translation)
python3 $opennmt/translate.py -model /home/rameshak/spinning-storage/rameshak/model/lstm_step_5000.pt -src $tes -output $evaluation/pred_tz.txt -replace_unk -verbose

#Evaluation -- measuring bleu
/home/rameshak/$pref/software/scripts/generic/multi-bleu.perl $ref < $evaluation/pred_tz.txt > $evaluation/results_tz



tes=corpus/testset_ub.$SL   
ref=corpus/testset_ub.$TL     

#decoding (Translation)
python3 $opennmt/translate.py -model /home/rameshak/spinning-storage/rameshak/model/lstm_step_5000.pt -src $tes -output $evaluation/pred_ub.txt -replace_unk -verbose

#Evaluation -- measuring bleu
/home/rameshak/$pref/software/scripts/generic/multi-bleu.perl $ref < $evaluation/pred_ub.txt > $evaluation/results_ub



tes=corpus/testset_wiki.$SL   
ref=corpus/testset_wiki.$TL     

#decoding (Translation)
python3 $opennmt/translate.py -model /home/rameshak/spinning-storage/rameshak/model/lstm_step_5000.pt -src $tes -output $evaluation/pred_wiki.txt -replace_unk -verbose

#Evaluation -- measuring bleu
/home/rameshak/$pref/software/scripts/generic/multi-bleu.perl $ref < $evaluation/pred_wiki.txt > $evaluation/results_wiki
