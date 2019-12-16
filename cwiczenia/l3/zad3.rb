#!/bin/ruby
# coding: utf-8
r=ARGV.shift

#puts grep_args
#while l=gets
#  if not l.scan(r).empty?
#    puts l
#  end
#end

puts readlines.select{|l| l =~ r }
