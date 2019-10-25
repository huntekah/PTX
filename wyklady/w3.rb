#!/usr/bin/env ruby
require 'getoptlong'


HELP_ME_PLEASE = <<END
  Some generic help message
END

opts = GetoptLong.new(
  ['--help', '-h', GetoptLong::NO_ARGUMENT],  
  ['--inverse', '-v', GetoptLong::NO_ARGUMENT],  
  ['--file', '-f', GetoptLong::REQUIRED_ARGUMENT],  
  ['--author', '-a', GetoptLong::REQUIRED_ARGUMENT] 
)

opts.each do |a,v|
  case a 
    when '--inverse'
      INVERSE = true
    when '--file'
      ARGV << v
    when '--help' then  puts HELP_ME_PLEASE; exit 0
  end
end
INVERSE = false unless defined? INVERSE

abort if ARGV.empty?

re = /#{ARGV.shift}/

  while l = gets
    puts l if (INVERSE ? (l !~ re) : (l=~ re))
  end

