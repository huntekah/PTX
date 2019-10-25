require 'rubygems'
require 'open-uri'
#require 'nokogiri'

def main
  greet_user
  choose_category
  #choose_subcategory
  #show_text
end

def greet_user
  greeting = <<-HERE_DOC
  Hello adventurer!
  Would you like to browse the Wikipedia?
  HERE_DOC

  printf greeting
end

def choose_category
  uri = 'https://en.wikipedia.org/wiki/Portal:Contents/Portals'
  doc =  open(uri)
  doc.readlines.each do |line|
    #puts line
    #break
    if line =~ /mw-headline/
      puts line
      # pisac z uzyciem nokogiri
      puts
    end
  end
  #puts doc.readlines 
end

main
