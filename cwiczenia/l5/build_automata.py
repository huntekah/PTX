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
    for word in words:
        max_state += 1
        print(f"0\t{max_state}\t{word[0]}")
        for letter in word[1:]:
            print(f"{max_state}\t{max_state+1}\t{letter}")
            max_state += 1
        print(f"{max_state}")

def main(words):
    build_automata(words)
               
if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    lines=sys.stdin.readlines()
    args = parser.parse_args()
    main(lines)

