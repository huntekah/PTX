#!/usr/bin/perl
use strict;
use warnings;

my $lines = 0;

while (<STDIN>){
    ++$lines;
}
print $lines,"\n";
