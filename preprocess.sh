#!/bin/bash

# this sample script preprocesses a sample corpus, including tokenization,
# truecasing, and subword segmentation. 
# for application to a different language pair,
# change source and target prefix, optionally the number of BPE operations,
# and the file names (currently, data/corpus and data/newsdev2016 are being processed)

# in the tokenization step, you will want to remove Romanian-specific normalization / diacritic removal,
# and you may want to add your own.
# also, you may want to learn BPE segmentations separately for each language,
# especially if they differ in their alphabet

mydir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. $mydir/settings.sh

# number of merge operations. Network vocabulary should be slightly larger (to include characters),
# or smaller if the operations are learned on the joint vocabulary
bpe_operations=89500

# tokenize
for prefix in $TRAIN $DEV
 do
   cat data/$prefix.$SRC | \
   $MOSESDECODER/scripts/tokenizer/normalize-punctuation.perl -l $SRC | \
   $MOSESDECODER/scripts/tokenizer/tokenizer.perl -a -l $SRC > data/$prefix.tok.$SRC

   cat data/$prefix.$TGT | \
   $MOSESDECODER/scripts/tokenizer/normalize-punctuation.perl -l $TGT | \
   $MOSESDECODER/scripts/tokenizer/tokenizer.perl -a -l $TGT > data/$prefix.tok.$TGT

 done

# clean empty and long sentences, and sentences with high source-target ratio (training corpus only)
$MOSESDECODER/scripts/training/clean-corpus-n.perl data/train.tok $SRC $TGT data/train.tok.clean 1 80

# train truecaser
$MOSESDECODER/scripts/recaser/train-truecaser.perl -corpus data/train.tok.clean.$SRC -model model/truecase-model.$SRC
$MOSESDECODER/scripts/recaser/train-truecaser.perl -corpus data/train.tok.clean.$TGT -model model/truecase-model.$TGT

# apply truecaser (cleaned training corpus)
for prefix in $TRAIN
 do
  $MOSESDECODER/scripts/recaser/truecase.perl -model model/truecase-model.$SRC < data/$prefix.tok.clean.$SRC > data/$prefix.tc.$SRC
  $MOSESDECODER/scripts/recaser/truecase.perl -model model/truecase-model.$TGT < data/$prefix.tok.clean.$TGT > data/$prefix.tc.$TGT
 done

# apply truecaser (dev/test files)
for prefix in $DEV
 do
  $MOSESDECODER/scripts/recaser/truecase.perl -model model/truecase-model.$SRC < data/$prefix.tok.$SRC > data/$prefix.tc.$SRC
  $MOSESDECODER/scripts/recaser/truecase.perl -model model/truecase-model.$TGT < data/$prefix.tok.$TGT > data/$prefix.tc.$TGT
 done

# train BPE
cat data/$TRAIN.tc.$SRC data/$TRAIN.tc.$TGT | $SUBWORD_NMT/learn_bpe.py -s $bpe_operations > model/$SRC$TGT.bpe

# apply BPE

for prefix in $TRAIN $DEV
 do
  $SUBWORD_NMT/apply_bpe.py -c model/$SRC$TGT.bpe < data/$prefix.tc.$SRC > data/$prefix.bpe.$SRC
  $SUBWORD_NMT/apply_bpe.py -c model/$SRC$TGT.bpe < data/$prefix.tc.$TGT > data/$prefix.bpe.$TGT
 done

# build network dictionary
$NEMATUS/data/build_dictionary.py data/$TRAIN.bpe.$SRC data/$TRAIN.bpe.$TGT
