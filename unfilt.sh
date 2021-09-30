#!/usr/bin/env sh

if [ -z "$1" ]; then
    echo "Usage: $0 <declaration>"
fi

FILE=$(mktemp /tmp/unfilt-file.XXXXXX)
DECL=$@
OUT="$FILE.so"

echo $DECL '{}' > $FILE

g++ -fPIC -shared -Wno-return-type -x c++ $FILE -o $OUT

objdump --syms $OUT | grep ".text" | tail -n1 | cut -s --fields=9 --delimiter=' '

rm $FILE $OUT
