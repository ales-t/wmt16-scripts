#/bin/sh

mydir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. $mydir/header.sh

sed 's/\@\@ //g' | \
$mosesdecoder/scripts/recaser/detruecase.perl
