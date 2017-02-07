#!/bin/sh

mydir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. $mydir/header.sh

#model prefix
prefix=model/model.npz

dev=data/newsdev2016.bpe.ro
ref=data/newsdev2016.tok.en

# decode
THEANO_FLAGS=mode=FAST_RUN,floatX=float32,device=$device,on_unused_input=warn python $NEMATUS/nematus/translate.py \
     -m $prefix.dev.npz \
     -i $dev \
     -o $dev.output.dev \
     -k 12 -n -p 1


./postprocess-dev.sh < $dev.output.dev > $dev.output.postprocessed.dev


## get BLEU
BEST=`cat ${prefix}_best_bleu || echo 0`
$MOSESDECODER/scripts/generic/multi-bleu.perl $ref < $dev.output.postprocessed.dev >> ${prefix}_bleu_scores
BLEU=`$MOSESDECODER/scripts/generic/multi-bleu.perl $ref < $dev.output.postprocessed.dev | cut -f 3 -d ' ' | cut -f 1 -d ','`
BETTER=`echo "$BLEU > $BEST" | bc`

echo "BLEU = $BLEU"

# save model with highest BLEU
if [ "$BETTER" = "1" ]; then
  echo "new best; saving"
  echo $BLEU > ${prefix}_best_bleu
  cp ${prefix}.dev.npz ${prefix}.npz.best_bleu
fi
