SL=hi
TL=ta
SPATH='/home/venkabal/spinning-storage/venkabal'
MPATH='/home/venkabal/spinning-storage/venkabal/mosesdecoder/scripts'
MBIN='/home/venkabal/spinning-storage/venkabal/mosesdecoder/bin'
EPATH='/home/venkabal/spinning-storage/venkabal/experiment2/hi-ta/smt_training'
KHTPATH='/home/venkabal/spinning-storage/venkabal/experiment2/hi-ta/kenlm_files'
CHTPATH='/home/venkabal/spinning-storage/venkabal/experiment2/hi-ta/corpus'
HTRAIN='/home/venkabal/spinning-storage/venkabal/experiment2/hi-ta/train'
devpref='/home/venkabal/spinning-storage/venkabal/experiment2/hi-ta/corpus/devset'
MOPATH='/home/venkabal/spinning-storage/venkabal/english-tamil/smt_training/binarised_model'

#Building a 5-gram language model using KneserNey
$MBIN/lmplz -o 5 -S 3G -T $SPATH/temp < $CHTPATH/train.clean.ta > $KHTPATH/training_ta.lm.arpa
$SPATH/mosesdecoder/bin/build_binary trie $KHTPATH/training_ta.lm.arpa $KHTPATH/training_ta.kenbinlm &>> $KHTPATH/lm.logs

#Model Training
$MPATH/training/train-model.perl --external-bin-dir $SPATH/mosesdecoder/tools -cores 10 \
-sort-batch-size 253 -sort-compress gzip -root-dir $HTRAIN/train -corpus $CHTPATH/train.clean -f hi -e ta \
-alignment grow-diag-final-and -reordering mslr-bidirectional-fe --reordering-smooth 0.8u -lm 0:5:$KHTPATH/training_ta.kenbinlm:9 \
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
nohup nice $SPATH/mosesdecoder/bin/moses -f $MOPATH/moses.ini < $CHTPATH/test/testset_ubuntu.hi > $CHTPATH/test/ubuntu.translated.ta 2> $CHTPATH/testubuntu.out
nohup nice $SPATH/mosesdecoder/bin/moses -f $MOPATH/moses.ini < $CHTPATH/test/testset_tanzil.hi > $CHTPATH/test/tanzil.translated.ta 2> $CHTPATH/testtanzil.out
nohup nice $SPATH/mosesdecoder/bin/moses -f $MOPATH/moses.ini < $CHTPATH/test/testset_kde4.hi > $CHTPATH/test/kde4.translated.ta 2> $CHTPATH/testkde4.out
nohup nice $SPATH/mosesdecoder/bin/moses -f $MOPATH/moses.ini < $CHTPATH/test/testset_gnome.hi > $CHTPATH/test/gnome.translated.ta 2> $CHTPATH/testgnome.out
echo 'Finished translating test data.....'

#Computing BLEU score
echo 'Starting BLEU score evaluation.....'
$MPATH/generic/multi-bleu.pl -lc $CHTPATH/test/testset_tanzil.ta < $CHTPATH/test/tanzil.translated.ta
$MPATH/generic/multi-bleu.pl -lc $CHTPATH/test/testset_kde4.ta < $CHTPATH/test/kde4.translated.ta
$MPATH/generic/multi-bleu.pl -lc $CHTPATH/test/testset_ubuntu.ta < $CHTPATH/test/ubuntu.translated.ta
$MPATH/generic/multi-bleu.pl -lc $CHTPATH/test/testset_gnome.ta < $CHTPATH/test/gnome.translated.ta
echo 'Finished computing BLEU Score.....'