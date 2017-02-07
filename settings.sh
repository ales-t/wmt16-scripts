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
