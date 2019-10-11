#!/usr/bin/bash

WHERE=$1
TASK=$2

find $WHERE -iregex ".*/"Task$2/"\(.*\.\(grm\|py\|cpp\|java\)\|run\)" -size +100c -exec ls -l '{}' ';' | sort -k 5n


find $WHERE -iregex ".*/"Task$2/"\(.*\.\(grm\|py\|cpp\|java\)\|run\)" |
while read K;
do
   echo '============================='
   echo $K
   cat $K
done
