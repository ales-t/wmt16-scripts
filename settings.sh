#!/bin/bash

# DEFINE ALL VARIABLES HERE

# theano device, in case you do not want to compute on gpu, change it to cpu
DEVICE=gpu

# path to moses decoder: https://github.com/moses-smt/mosesdecoder
MOSESDECODER=/path/to/mosesdecoder

# path to subword segmentation scripts: https://github.com/rsennrich/subword-nmt
SUBWORD_NMT=/path/to/subword-nmt 

# path to nematus ( https://www.github.com/rsennrich/nematus )
NEMATUS=/path/to/nematus

# suffix of source language files
SRC=en

# suffix of target language files
TGT=cs

# name of the training corpus prefix
TRAIN=train

# name of the dev corpus prefix
DEV=dev

# name of the test corpus prefix
TEST=test

# vocabulary size (number of BPE splits is automatically derived from this)
VOCAB_SIZE=90000

# embedding size
DIM_WORD=500

# size of the hidden layer
DIM=1024

# (initial) learning rate
LRATE=0.0001

# which optimization algorithm
OPTIMIZER=adam

# maximum sentence length
MAXLEN=50

# training batch size
BATCH_SIZE=80

# batch size for validation
VALID_BATCH_SIZE=80

# validation frequency
VALID_FREQ=10000

# validation frequency
SAMPLE_FREQ=5000

# how often to save the model
SAVE_FREQ=30000

# use dropout? (set to 'yes' to enable)
DROPOUT=no

# dropout settings at different stages
DROPOUT_EMBEDDING=0.2 # dropout for input embeddings 
DROPOUT_HIDDEN=0.2 # dropout for hidden layers 
DROPOUT_SOURCE=0.1 # dropout source words 
DROPOUT_TARGET=0.1 # dropout target words 
