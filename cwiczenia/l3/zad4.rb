#!/bin/ruby
# coding: utf-8
#puts ARGV
args = ARGV


#while a=gets
#  [a].grep(args)
#end
STDIN.read.split("\n").each do |a|
  #puts(a)
  puts [a].grep(args)
end



#a.grep(/A/)


