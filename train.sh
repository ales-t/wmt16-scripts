#!/bin/bash

mydir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# automatically export all variables from settings.sh
set -a
# source the config
. $mydir/settings.sh
# stop automatic export
set +a

THEANO_FLAGS=mode=FAST_RUN,floatX=float32,device=$DEVICE,on_unused_input=warn python -u config.py
