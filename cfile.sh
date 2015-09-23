#!/usr/bin/env sh

# This script is meant to be a self test for the parser.
# Assuming it fully built with the old compiler (and so it's valid), it also
# must be capable to parse itself.
# All the .fork and .ford files under src/ must parse.

ROOTDIR="$(dirname $0)"


for FILE in $(find src/ -name '*.fork' -or -name '*.ford')
do

  echo "Adding $FILE..."

  if not env FORDPATHS="$ROOTDIR/src/ford/internal/":"$ROOTDIR/src/ford/" forkc1 "$FILE" >> libfork.c
  then
    exit $?
  fi

done

echo "Preprocessing..."
cpp -I$ROOTDIR/build/include/ libfork.c > libfork.i

rm libfork.c
