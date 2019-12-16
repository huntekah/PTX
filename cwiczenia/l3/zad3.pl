#!/usr/bin/perl
use strict;
use warnings;

my ($file, $command) = @ARGV;

open(my $fh, '<', $file);

while (my $row = <$fh>){
    my $result = grep $command $row
    print $result, "\n";
}
#print $lines,"\n";
