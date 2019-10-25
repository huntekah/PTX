#!/usr/bin/env ruby
require 'getoptlong'
require_relative 'predefined_constants.rb'

$recurrent_args = false

$defines_order = []
$defines = {}

def main
  parse_options
  ARGV.each{|f| file_preprocessor f}
end

def parse_options
    opts = GetoptLong.new(
      ['--help', '-h', GetoptLong::NO_ARGUMENT],  
      ['--file', '-f', GetoptLong::REQUIRED_ARGUMENT],  
      ['--author', '-a', GetoptLong::NO_ARGUMENT],
      ['--recurrent', '-r', GetoptLong::NO_ARGUMENT] 
    )
    
    opts.each do |a,v|
      case a 
        when '--file'       then  ARGV << v
        when '--help'       then  puts HELP_ME_PLEASE; exit 0
        when '--author'     then  puts AUTHOR; exit 0
        when '--recurrent'  then  $recurrent_args = true;
      end
    end
    #print $recurrent_args
    puts ARGV
    abort if ARGV.empty?
end


#re = /#{ARGV.shift}/
def file_preprocessor file
  puts "Hi in file preprocessor " + file.to_s
  #while l = gets(file).each_line
  File.readlines(file).each do |line|
   # puts l.class
    #puts l
    case line
    when /^\s*#define\s+(\S+)\s*(.*)$/
      #puts l
      #$defines_order.push($1) # only if $1 not in arr
      preprocess_define($1,$2)
    when /^\s*#include\s+(\S+)$/
      file_preprocessor($1)
    else
      apply_defined_variables(line)
    end
      #puts l
    #puts l if (INVERSE ? (l !~ re) : (l=~ re))
  end
end

def preprocess_define(constant, value)
  puts constant
  if constant =~ /^\s*(.*)\((.*)\)\s*$/ then
    constant_function = $1
    function_arguments = $2.split(",")
    puts function_arguments
    #printf("1: ",$1,"2: ",$2,"\n")
  else
    $defines_order.push(constant)
    $defines[constant] = value   
  end
end

def apply_defined_variables(text)
  for key in $defines_order 
    puts $defines[key]
  end
end

main
