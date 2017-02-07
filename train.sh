#!/bin/bash

mydir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. $mydir/settings.sh

THEANO_FLAGS=mode=FAST_RUN,floatX=float32,device=$DEVICE,on_unused_input=warn python config.py
