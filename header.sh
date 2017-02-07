#!/bin/bash

# DEFINE ALL VARIABLES HERE

# theano device, in case you do not want to compute on gpu, change it to cpu
device=gpu

# path to moses decoder: https://github.com/moses-smt/mosesdecoder
mosesdecoder=/path/to/mosesdecoder

# path to subword segmentation scripts: https://github.com/rsennrich/subword-nmt
subword_nmt=/path/to/subword-nmt 

# path to nematus ( https://www.github.com/rsennrich/nematus )
nematus=/path/to/nematus

# suffix of source language files
SRC=ro

# suffix of target language files
TRG=en

