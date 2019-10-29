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
    puts ">> Read: " +  line
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
  #puts "whole constant: " +  constant
  #puts "expression: " + value
  if constant =~ /^\s*(.*)\((.*)\)\s*$/
    constant_function = $1
    function_arguments = $2.split(",")
    #puts "args: " + function_arguments.to_s
    #puts "constant: " + constant_function
    $defines_order.push(constant_function)
    $defines[constant_function] = [function_arguments,value]
  else
    $defines_order.push(constant)
    $defines[constant] = value   
  end
  puts $defines.to_s
  #puts $defines_order.to_s
end

def apply_defined_variables(text)
  updated_text = apply_once_defined_variables(text)
  if $recurrent_args
    while updated_text 
      text = updated_text
      updated_text = apply_once_defined_variables(text)
    end
  end  
  #puts "updated: " + updated_text.to_s + "text." + text.class.to_s + ": " + text
  puts "Write< " + (updated_text ? updated_text : text).to_s
end

def apply_once_defined_variables(text)
  for key in $defines_order
    #puts "key " + key.to_s + " in? " + $defines_order.to_s
    if text.include? key then #include or scan?
      
      if text =~ /^\s*#{key}\((.*?)\).*$/ # how to do it in ruby?
        value_content = $1
        #puts value_content.class
        values_array = value_content.split(",")
        #puts "..values_array: " + values_array.to_s
        #puts "..key \"" + key + "\" text: " + text + "..defines[key]: " + $defines[key].to_s
        break unless $defines[key].is_a?(Array)
        break unless values_array.length == $defines[key].length
        substitution = $defines[key][1].dup
        $defines[key][0].zip(values_array).each do |sub_key, value|
          #puts "..sub_key: " + sub_key + " value: " + value
          substitution.gsub!(sub_key,value)
          #puts "substitution for today is: " + substitution
        end
        text.sub!(/#{key}\(.*?\)/,substitution)
        #text = "PODSTAWIONKO"
        return text
      elsif $defines[key].is_a?(String)
        #TUTAJ LAPIEJMY slowa bez nawiasow
        #puts $defines[key].class
        #text = "poDStawianKO"
        return text.sub!(key,$defines[key])
      end
      #puts text
      #puts $defines[key].to_s
    #else
    #  puts "no key for text: " + text
    end
    #return text
  end
  return nil
end

main
