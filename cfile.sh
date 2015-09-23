#!/usr/bin/env sh


ROOTDIR="$(cd $(dirname $0); pwd)"

rm -f $ROOTDIR/libfork.{c,i}

for FILE in $(find $ROOTDIR/src/ -name '*.fork')
do

  echo "Adding $FILE..."

  if ! env FORDPATHS="$ROOTDIR/build/ford/internal/":"$ROOTDIR/build/ford/" forkc1 "$FILE" >> $ROOTDIR/libfork.c
  then
    exit $?
  fi

done

find $ROOTDIR/src/ -name '*.c' -exec cat {} \; >> $ROOTDIR/libfork.c

echo "Preprocessing..."
cpp -I$ROOTDIR/build/include/ $ROOTDIR/libfork.c > $ROOTDIR/libfork.i
