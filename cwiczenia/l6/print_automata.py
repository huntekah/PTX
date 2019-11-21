#!/usr/bin/env python

"""
wydrukuj słowa któreprzyjmuje automacik
cat automat.fst | ./basename $0
Author:
Krzysztof Jurkiewicz
"""
import sys
import argparse

final_states = set()
transitions = dict()
max_state=0

def print_automata(state=0,word=""):
    if state in final_states:
        print(word)
        if state == max_state:
            return
    for i in range(max_state+1):
        if (state,i) in transitions:
            print_automata(i,word + transitions[(state,i)])

def read_automata(lines):
    global max_state
    lines = [ [int(y) if y.isdigit() else y for y in x.split()] for x in lines ]
    for line in lines:
        if len(line) == 1:
            final_states.add(line[0])
        else:
            start,stop,label = line
            transitions[(start,stop)] = label
            max_state = max(max_state,stop)
    return(final_states,transitions)
 

def main(lines):
    read_automata(lines)
    print_automata()
               
if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    lines=sys.stdin.readlines()
    args = parser.parse_args()
    main(lines)

