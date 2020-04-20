#!/bin/bash

SL=en
TL=ta

#we have 4 test sets: kde4, opensubtitles, pmindia, tanzil.


pref=spinning-storage/rameshak
~/$pref/software/subword_nmt/learn_bpe.py --input corpus/train.$SL -s 32000 -o corpus/bpe.$SL.32k &
~/$pref/software/subword_nmt/learn_bpe.py --input corpus/train.$TL -s 32000 -o corpus/bpe.$TL.32k &
wait

~/$pref/software/subword_nmt/apply_bpe.py -c corpus/bpe.$SL.32k < corpus/train.$SL > corpus/train.BPE.$SL &
~/$pref/software/subword_nmt/apply_bpe.py -c corpus/bpe.$TL.32k < corpus/train.$TL > corpus/train.BPE.$TL &

~/$pref/software/subword_nmt/apply_bpe.py -c corpus/bpe.$SL.32k < corpus/testset_kde4.$SL > corpus/testset_kde4.BPE.$SL &
~/$pref/software/subword_nmt/apply_bpe.py -c corpus/bpe.$TL.32k < corpus/testset_kde4.$TL > corpus/testset_kde4.BPE.$TL &


~/$pref/software/subword_nmt/apply_bpe.py -c corpus/bpe.$SL.32k < corpus/testset_opensubtitles.$SL > corpus/testset_opensubtitles.BPE.$SL &
~/$pref/software/subword_nmt/apply_bpe.py -c corpus/bpe.$TL.32k < corpus/testset_opensubtitles.$TL > corpus/testset_opensubtitles.BPE.$TL &


~/$pref/software/subword_nmt/apply_bpe.py -c corpus/bpe.$SL.32k < corpus/testset_pmindia.$SL > corpus/testset_pmindia.BPE.$SL &
~/$pref/software/subword_nmt/apply_bpe.py -c corpus/bpe.$TL.32k < corpus/testset_pmindia.$TL > corpus/testset_pmindia.BPE.$TL &


~/$pref/software/subword_nmt/apply_bpe.py -c corpus/bpe.$SL.32k < corpus/testset_tanzil.$SL > corpus/testset_tanzil.BPE.$SL &
~/$pref/software/subword_nmt/apply_bpe.py -c corpus/bpe.$TL.32k < corpus/testset_tanzil.$TL > corpus/testset_tanzil.BPE.$TL &

~/$pref/software/subword_nmt/apply_bpe.py -c corpus/bpe.$SL.32k < corpus/devset.$SL > corpus/devset.BPE.$SL &
~/$pref/software/subword_nmt/apply_bpe.py -c corpus/bpe.$TL.32k < corpus/devset.$TL > corpus/devset.BPE.$TL &

wait
echo 'Hi, Proc done...'


