#!/bin/bash -ex

PREFIX=pjn-2016

cd ..

STUDENT_DIR=`ls -d ${PREFIX}-s*`

echo "USING $STUDENT_DIR"

rm -rf arena
mkdir arena

cp -R $STUDENT_DIR/* arena/
ln -s ../$STUDENT_DIR/.git arena/.git

cp "${PREFIX}/create-report.pl" arena/
cp "${PREFIX}/count-points.pl" arena/
cp "${PREFIX}/overrides.txt" arena/
cp "${PREFIX}/Makefile" arena/

for TX in X01 X02 X03 A01 A02 A03 A03 A04 A05 A06 A07 A08 A09 B01 B02 B03 B04 C01 C02 C03
do
    mkdir -p arena/Task$TX
done

find $PREFIX -name "*.in"  -o -name "*.exp" | while read K; do
cp $K arena/${K#*/}
done

cd $PREFIX

for T in Task???
do
    mkdir -p ../arena/$T
done

cd ..

find ${PREFIX} -regextype egrep -regex '.*/(description.txt|.*\.arg|.*\.in|.*\.exp)' -print | while read T; do cp $T ${T/${PREFIX}/arena}; done
