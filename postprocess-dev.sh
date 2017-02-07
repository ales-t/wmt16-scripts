#/bin/sh

mydir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. $mydir/settings.sh

sed 's/\@\@ //g' | \
$MOSESDECODER/scripts/recaser/detruecase.perl
