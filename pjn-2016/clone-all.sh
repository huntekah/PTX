#!/usr/bin/bash

WHERE=$1

while read K;
do
    (cd $WHERE ; git clone 'ssh://gitolite@re-research.wmi.amu.edu.pl:1977/pjn-2016-s'$K)
done < indexes.txt
