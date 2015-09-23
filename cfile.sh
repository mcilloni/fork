#!/usr/bin/env sh


ROOTDIR="$(cd $(dirname $0); pwd)"

echo "Removing existent files (ctrans)"
rm -f $ROOTDIR/forkc1.{c,i}
rm -f $ROOTDIR/libfork-c.c
rm -f $ROOTDIR/cbuild-*.txz

echo "Compiling libfork..."
if ! sh $ROOTDIR/libfork/cfile.sh
then
  exit 1
fi

cp libfork/libfork.c forkc1.c
cp libfork/libfork-c.c .

for FILE in $(find $ROOTDIR/src/ -name '*.fork')
do

  echo "Adding $FILE..."

  if ! env FORDPATHS="$ROOTDIR/libfork/build/ford/":"$ROOTDIR/build/ford/" forkc1 "$FILE" >> forkc1.c
  then
    exit $?
  fi

done

echo "Preprocessing..."
cpp -I$ROOTDIR/build/include/ -I$ROOTDIR/libfork/build/include/ forkc1.c >> forkc1.i

echo "Tarballing..."
tar cf - $ROOTDIR/forkc1.i $ROOTDIR/libfork-c.c $ROOTDIR/build/{forkc,fordc,forkl} | xz -9e > $ROOTDIR/cbuild-$(date +%s).txz
