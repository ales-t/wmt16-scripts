#!/bin/bash

mydir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. $mydir/settings.sh

THEANO_FLAGS=mode=FAST_RUN,floatX=float32,device=$DEVICE,on_unused_input=warn python $NEMATUS/nematus/translate.py \
     -m model/model.npz \
     -i data/$TEST.bpe.$SRC \
     -o data/$TEST.output \
     -k 12 -n -p 1

echo "Tokenized case-sensitive BLEU:" >&2
cat data/$TEST.output \
  | sed 's/\@\@ //g' \
  | $MOSESDECODER/scripts/generic/multi-bleu.perl data/test.tc.$TGT
