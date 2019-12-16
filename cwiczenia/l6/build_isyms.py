#!/usr/bin/env python

"""
Zbuduj alfabet z liczby słów
cat words | ./basename $0 > output
Author:
Krzysztof J.
"""


import sys
import argparse

def build_isyms(words):
    max_state = 0
    words = "".join("".join((set(sorted("".join(words))))).split())
    print(f"<eps>\t{max_state}")
    for letter in words:
        max_state += 1
        print(f"{max_state}\t{letter}")

def main(words):
    build_isyms(words)
               
if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    args = parser.parse_args()
    lines=sys.stdin.readlines()
    main(lines)

