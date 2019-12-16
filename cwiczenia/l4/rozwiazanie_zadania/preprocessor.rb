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
        when '--help'       then  puts HELP_ME_PLEASE; puts AUTHOR exit 0
        when '--author'     then  puts AUTHOR; exit 0
        when '--recurrent'  then  $recurrent_args = true;
      end
    end
    #puts ARGV
    abort if ARGV.empty?
end


def file_preprocessor file
  #puts "Hi in file preprocessor " + file.to_s
  File.readlines(file).each do |line|
    #puts ">> Read: " +  line
    case line
    when /^\s*#define\s+(\S+)\s*(.*)$/
      preprocess_define($1,$2)
    when /^\s*#include\s+(\S+)$/
      file_preprocessor($1)
    else
      apply_defined_variables(line)
    end
  end
end

def preprocess_define(constant, value)
  if constant =~ /^\s*(.*)\((.*)\)\s*$/
    constant_function = $1
    #puts ">>>" + $2.to_s
    function_arguments = $2.split(",")
    $defines_order.push(constant_function)
    $defines[constant_function] = [function_arguments,value]
  else
    $defines_order.push(constant)
    $defines[constant] = value   
  end
  #puts $defines.to_s
end

def apply_defined_variables(text)
  updated_text = apply_once_defined_variables(text)
  if $recurrent_args
    while updated_text 
      text = updated_text
      updated_text = apply_once_defined_variables(text)
    end
  end  
  #puts "Write< " + (updated_text ? updated_text : text).to_s
  puts (updated_text ? updated_text : text).to_s
end

def apply_once_defined_variables(text)
  for key in $defines_order
    if text.include? key then #include or scan?
      if text =~ /^.*#{key}\((.*?)\).*$/ 
        
        value_content = $1
        values_array = value_content.split(",")
        #puts value_content.to_s + values_array.to_s
        break unless $defines[key].is_a?(Array)
        break unless values_array.length == $defines[key][0].length
        substitution = $defines[key][1].dup
        
        $defines[key][0].zip(values_array).each do |sub_key, value|
          substitution.gsub!(sub_key,value)
        end

        text.sub!(/#{key}\(.*?\)/,substitution)
        return text
      
      elsif $defines[key].is_a?(String)
        return text.sub!(key,$defines[key])
      end
    end
  end
  return nil
end

main
