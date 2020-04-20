SL=en
TL=ta
MPATH='/home/venkabal/spinning-storage/venkabal/mosesdecoder/scripts'
MBIN='/home/venkabal/spinning-storage/venkabal/mosesdecoder/bin'
CETPATH='/home/venkabal/spinning-storage/venkabal/experiment2/en-ta/corpus'
KETPATH='/home/venkabal/spinning-storage/venkabal/experiment2/en-ta/kenlm_files'
ETRAIN='/home/venkabal/spinning-storage/venkabal/experiment2/en-ta/train'
TUNING='/home/venkabal/spinning-storage/venkabal/experiment2/en-ta/tuning/mira_tuning'
MOSESINI='/home/venkabal/spinning-storage/venkabal/experiment2/en-ta/smt_training/binarised_model'
devpref='/home/venkabal/spinning-storage/venkabal/experiment2/en-ta/corpus/devset'
EPATH='/home/venkabal/spinning-storage/venkabal/experiment2/en-ta/smt_training'
MOPATH='/home/venkabal/spinning-storage/venkabal/experiment2/en-ta/smt_training/binarised_model'

#Building a 5-gram language model for EN-TA translation
$MBIN/lmplz -o 5 -S 3G -T $SPATH/temp < $SPATH/train.clean.ta > $KETPATH/training_ta.lm.arpa
$SPATH/mosesdecoder/bin/build_binary trie $KETPATH/training_ta.lm.arpa $KETPATH/training_ta.kenbinlm &>> $KETPATH/lm.logs

#Model Training EN-TA
$SPATH/mosesdecoder/scripts/training/train-model.perl --external-bin-dir $SPATH/mosesdecoder/tools -cores 10 \
-sort-batch-size 253 -sort-compress gzip -root-dir $ETRAIN/train -corpus $CETPATH/train.clean -f hi -e ta \
-alignment grow-diag-final-and -reordering mslr-bidirectional-fe --reordering-smooth 0.8u -lm 0:5:$KETPATH/training_ta.kenbinlm:9 \
-score-options ''\''--KneserNey'\''' --first-step 1 --last-step 9 --max-phrase-length 7

#Model Tuning Using MIRA
nohup nice $MPATH/training/mert-moses.pl --mertdir $MBIN --input $devpref.$SL --refs $devpref.$TL --decoder $MBIN/moses --config \
$MOSESINI/moses.ini --working-dir $TUNING --rootdir $MPATH --nbest=200 --batch-mira --no-filter-phrase-table --batch-mira-args '-J 300' \
--decoder-flags '-distortion-limit 12 -stack 2000 -cube-pruning-pop-limit 2000 -search-algorithm 1 -v 0 -threads 8' \
--return-best-dev &> $TUNING/tuning_mira.log

#Binarising model for faster loading

$MBIN/processLexicalTableMin -in $EPATH/train/model/reordering-table.wbe-mslr-bidirectional-fe.gz -nscores 4 -out \
$EPATH/binarised-model/reordering-table

$MBIN/processPhraseTableMin -in $EPATH/train/model/phrase-table.gz -nscores 4 -out $EPATH/binarised-model/reordering-table

#Translate the test set
echo 'Starting test data......'
nohup nice $SPATH/mosesdecoder/bin/moses -f $MOPATH/moses.ini < $CETPATH/test/testset_ubuntu.en > $CETPATH/test/ubuntu.translated.ta 2> $CETPATH/testubuntu.out
nohup nice $SPATH/mosesdecoder/bin/moses -f $MOPATH/moses.ini < $CETPATH/test/testset_tanzil.en > $CETPATH/test/tanzil.translated.ta 2> $CETPATH/testtanzil.out
nohup nice $SPATH/mosesdecoder/bin/moses -f $MOPATH/moses.ini < $CETPATH/test/testset_kde4.en > $CETPATH/test/kde4.translated.ta 2> $CETPATH/testkde4.out
nohup nice $SPATH/mosesdecoder/bin/moses -f $MOPATH/moses.ini < $CETPATH/test/testset_pmindia.en > $CETPATH/test/pmindia.translated.ta 2> $CETPATH/testpmindia.out
echo 'Finished translating test data.....'

#Computing BLEU score
echo 'Starting BLEU score evaluation.....'
$MPATH/generic/multi-bleu.pl -lc $CETPATH/test/testset_tanzil.ta < $CETPATH/test/tanzil.translated.ta
$MPATH/generic/multi-bleu.pl -lc $CETPATH/test/testset_kde4.ta < $CETPATH/test/kde4.translated.ta
$MPATH/generic/multi-bleu.pl -lc $CETPATH/test/testset_ubuntu.ta < $CETPATH/test/ubuntu.translated.ta
$MPATH/generic/multi-bleu.pl -lc $CETPATH/test/testset_pmindia.ta < $CETPATH/test/pmindia.translated.ta
echo 'Finished computing BLEU Score.....'
