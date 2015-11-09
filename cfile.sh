#!/usr/bin/env sh


ROOTDIR="$(cd $(dirname $0); pwd)"
cd $ROOTDIR

echo "Cleaning up..."
rm -f cbuild-*.txz
rm -rf cbuild/

echo "Compiling libfork..."
if ! sh libfork/cfile.sh
then
  exit 1
fi

mkdir cbuild
cp libfork/libfork.c cbuild/forkc1.c
cp libfork/libfork-c.c cbuild

for FILE in $(find src/ -name '*.fork')
do

  echo "Adding $FILE..."

  if ! env FORDPATHS="$ROOTDIR/libfork/build/ford/":"$ROOTDIR/build/ford/" forkc1 "$FILE" >> cbuild/forkc1.c
  then
    exit $?
  fi

done

echo "Preprocessing..."
cpp -I$ROOTDIR/build/include/ -I$ROOTDIR/libfork/build/include/ cbuild/forkc1.c >> cbuild/forkc1.i

cp build/{forkc,fordc,forkl} cbuild
pushd cbuild

echo "Tarballing..."
tar cf - * | xz -9e > $ROOTDIR/cbuild-$(date +%s).txz

popd

rm -r cbuild
