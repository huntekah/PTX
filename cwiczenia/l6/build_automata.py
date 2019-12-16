#!/usr/bin/env python

"""
Zbuduj automat z liczby słów
cat words | ./basename $0 > output
Author:
Krzysztof J.
"""


import sys
import argparse

def build_automata(words):
    max_state = 0
    words = [ x.strip() for x in words ]
    #without labels
    if len(words[0].split()) == 1:
        for word in words:
            max_state += 1
            print(f"0\t{max_state}\t{word[0]}")
            for letter in word[1:]:
                print(f"{max_state}\t{max_state+1}\t{letter}")
                max_state += 1
            print(f"{max_state}")
    #with labels
    else:
        for word, label in [ x.split() for x in words]:
            max_state += 1
            print(f"0\t{max_state}\t{word[0]}\t{label[0]}")
            for index in range(1,max(len(word),len(label))):
                #TUTAJ OBSLUGA GWIAZDKI, [a-z] etc. 
                if index < len(label) and index < len(word):
                    print(f"{max_state}\t{max_state+1}\t{word[index]}\t{label[index]}")
                elif index >= len(word):
                    print(f"{max_state}\t{max_state+1}\t<eps>\t{label[index]}")
                else:
                    print(f"{max_state}\t{max_state+1}\t{word[index]}\t<eps>")
                max_state += 1
            print(f"{max_state}")

def main(words):
    build_automata(words)
               
if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    args = parser.parse_args()
    lines=sys.stdin.readlines()
    main(lines)

