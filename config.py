import numpy
import os
import sys

VOCAB_SIZE = int(os.environ['VOCAB_SIZE'])
SRC = os.environ['SRC']
TGT = os.environ['TGT']
DEV = os.environ['DEV']
TRAIN = os.environ['TRAIN']
DATA_DIR = "data/"
USE_DROPOUT = os.environ['DROPOUT'] == 'yes'

from nematus.nmt import train

if __name__ == '__main__':
    validerr = train(saveto='model/model.npz',
                    reload_=True,
                    dim_word=int(os.environ['DIM_WORD']),
                    dim=int(os.environ['DIM']),
                    n_words=VOCAB_SIZE,
                    n_words_src=VOCAB_SIZE,
                    decay_c=0.,
                    clip_c=1.,
                    lrate=float(os.environ['LRATE']),
                    optimizer=os.environ['OPTIMIZER'],
                    maxlen=int(os.environ['MAXLEN']),
                    batch_size=int(os.environ['BATCH_SIZE']),
                    valid_batch_size=int(os.environ['VALID_BATCH_SIZE']),
                    datasets=[DATA_DIR + '/' + TRAIN + '.bpe.' + SRC, DATA_DIR + '/' + TRAIN + '.bpe.' + TGT],
                    valid_datasets=[DATA_DIR + '/' + DEV + '.bpe.' + SRC, DATA_DIR + '/' + DEV + '.bpe.' + TGT],
                    dictionaries=[DATA_DIR + '/' + TRAIN + '.bpe.' + SRC + '.json', DATA_DIR + '/' + TRAIN + '.bpe.' + TGT + '.json' ],
                    validFreq=int(os.environ['VALID_FREQ']),
                    dispFreq=1000,
                    saveFreq=int(os.environ['SAVE_FREQ']),
                    sampleFreq=10000,
                    use_dropout=USE_DROPOUT,
                    dropout_embedding=float(os.environ['DROPOUT_EMBEDDING']),
                    dropout_hidden=float(os.environ['DROPOUT_HIDDEN']),
                    dropout_source=float(os.environ['DROPOUT_SOURCE']),
                    dropout_target=float(os.environ['DROPOUT_TARGET']),
                    overwrite=False,
                    external_validation_script='./validate.sh')
    print validerr
