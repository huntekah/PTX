#!/usr/bin/python
# -*- coding: utf-8 -*-

"""
Skrypt budujący automat skończenie stanowy z listy słów.
Użycie:
cat words.txt | python buildautomata.py > output.txt
Autor:
Bartosz Kosowski
"""

import sys

def build_automata(words_file):
    """Buduje automat"""
    last_state = 0
    for word in words_file:
        last_state += 1
        #print "Word: ", word.strip()
        letters = list(word.strip())
        print "0 %d %s %s" % (last_state, letters[0], letters[0])
        for i in range(1, len(letters)):
            print "%d %d %s %s" % (last_state, last_state+1, letters[i], letters[i])
            last_state += 1
        print last_state

if __name__ == '__main__':
#    if (len(sys.argv) != 2) {
#        print "Uzycie skryptu: \ncat words.txt | python buildautomata.py > output.txt"
#        sys.exit(1)
#    }
    automata = build_automata(sys.stdin)
