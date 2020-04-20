#!/bin/bash

mkdir -p model

model=model
corpus=corpus

SL=hi
TL=ta
pref=spinning-storage/rameshak


echo 'starting model training'
echo 'started preprocessing the data '
python3 /home/rameshak/$pref/software/OpenNMT-py/preprocess.py -train_src $corpus/train.BPE.$SL -train_tgt $corpus/train.BPE.$TL -valid_src $corpus/devset.BPE.$SL -valid_tgt corpus/devset.BPE.$TL \
-save_data corpus/model_data \
-share_vocab \
-shard_size 100000  
echo 'preprocessed data saved in corpus/model_data
echo 'starting to train the data 
python3 /home/rameshak/$pref/software/OpenNMT-py/train.py -data corpus/model_data -save_model $model/lstm  \
-train_steps 1500000 \
-world_size 2 \
-gpu_ranks 0 1 

echo 'model saved'
