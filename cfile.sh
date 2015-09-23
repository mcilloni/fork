#!/usr/bin/env sh


ROOTDIR="$(cd $(dirname $0); pwd)"

echo "Removing existent files..."
rm -f $ROOTDIR/libfork.{c,i}
rm -f $ROOTDIR/libfork-c.c

for FILE in $(find $ROOTDIR/src/ -name '*.fork')
do

  echo "Adding $FILE..."

  if ! env FORDPATHS="$ROOTDIR/build/ford/internal/":"$ROOTDIR/build/ford/" forkc1 "$FILE" >> $ROOTDIR/libfork.c
  then
    exit $?
  fi

done

echo "Gathering all handwritten C files..."
find $ROOTDIR/src/ -name '*.c' -exec cat {} \; >> $ROOTDIR/libfork-c.c

echo "Preprocessing..."
cpp -I$ROOTDIR/build/include/ $ROOTDIR/libfork.c > $ROOTDIR/libfork.i
