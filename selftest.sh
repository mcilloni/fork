#!/usr/bin/env sh

# This script is meant to be a self test for the parser.
# Assuming it fully built with the old compiler (and so it's valid), it also
# must be capable to parse itself.
# All the .fork and .ford files under src/ must parse.

I=0
SUCCESS=0
TOTAL=$(find src/ -name '*.fork' -or -name '*.ford' | wc -l)
GREEN="\033[01;32m"
RED="\033[01;31m"
NORMAL="\033[00m"
BEGIN=$(date +%s)

for FILE in $(find src/ -name '*.fork' -or -name '*.ford')
do
  let I=I+1

  printf "%-40s: " "$FILE"

  if ./examples/ex semxample $FILE > /dev/null
  then
    let SUCCESS=SUCCESS+1
    echo -e "$GREEN success $NORMAL"
  else
    echo -e "$RED failure $NORMAL"
  fi

done

printf "Success: [%d/%d] files in %d seconds\n" $SUCCESS $TOTAL "$(expr $(date +%s) - $BEGIN)"
