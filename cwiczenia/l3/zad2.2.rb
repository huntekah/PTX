#!/bin/ruby

puts readlines.map{|l| l.scan /\d+/}.flatten.map(&:to_i).reduce(0,:+)
