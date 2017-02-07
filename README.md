This directory contains some sample files and configuration scripts for training a simple neural MT model

INSTRUCTIONS
------------

Set all required variables in the global settings file:

  ./settings.sh

As a first step, put your data in the following directory:

  ./data

By default, the names of your files should be train.$SRC, train.$TGT, dev.$SRC etc.

Then, preprocess the training, dev and test data:

  ./preprocess.sh

Then, start training: on normal-size data sets, this will take about 1-2 weeks to converge.
Models are saved regularly, and you may want to interrupt this process without waiting for it to finish.

  ./train.sh

Given a model, preprocessed text can be translated thusly:

  ./translate.sh

Finally, you may want to post-process the translation output, namely merge BPE segments,
detruecase and detokenize:

  ./postprocess-test.sh < data/newsdev2016.output > data/newsdev2016.postprocessed
