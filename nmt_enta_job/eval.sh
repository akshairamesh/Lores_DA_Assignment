#!/bin/bash

pref=spinning-storage/rameshak
opennmt=/home/rameshak/$pref/software/OpenNMT-py
model = model
SL=en
TL=ta
#we have 4 test sets: kde4, opensubtitles, pmindia, tanzil.

tes=corpus/testset_kde4.$SL   
ref=corpus/testset_kde4.$TL     

nvidia-smi 

evaluation=evaluation

mkdir $evaluation -p

# Decoding (translation)
python3 $opennmt/translate.py -model /home/rameshak/spinning-storage/rameshak/model/lstm_step_5000.pt -src $tes -output $evaluation/pred_kde.txt -replace_unk -verbose

#Evaluation -- measuring bleu
/home/rameshak/$pref/software/scripts/generic/multi-bleu.perl $ref < $evaluation/pred_kde.txt > $evaluation/results_kde4



tes=corpus/testset_opensubtitles.$SL   
ref=corpus/testset_opensubtitles.$TL     

#decoding (Translation)
python3 $opennmt/translate.py -model /home/rameshak/spinning-storage/rameshak/model/lstm_step_5000.pt -src $tes -output $evaluation/pred_opensub.txt -replace_unk -verbose

#Evaluation -- measuring bleu
/home/rameshak/$pref/software/scripts/generic/multi-bleu.perl $ref < $evaluation/pred_opensub.txt > $evaluation/results_opensub



tes=corpus/testset_pmindia.$SL   
ref=corpus/testset_pmindia.$TL     

#decoding (Translation)
python3 $opennmt/translate.py -model /home/rameshak/spinning-storage/rameshak/model/lstm_step_5000.pt -src $tes -output $evaluation/pred_pmindia.txt -replace_unk -verbose

#Evaluation -- measuring bleu
/home/rameshak/$pref/software/scripts/generic/multi-bleu.perl $ref < $evaluation/pred_india.txt > $evaluation/results_pmindia



tes=corpus/testset_tanzil.$SL   
ref=corpus/testset_tanzil.$TL     

#decoding (Translation)
python3 $opennmt/translate.py -model /home/rameshak/spinning-storage/rameshak/model/lstm_step_5000.pt -src $tes -output $evaluation/pred_tz.txt -replace_unk -verbose

#Evaluation -- measuring bleu
/home/rameshak/$pref/software/scripts/generic/multi-bleu.perl $ref < $evaluation/pred_tz.txt > $evaluation/results_tz
