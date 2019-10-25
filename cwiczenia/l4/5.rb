
h = {}
h.default = 0

while l=gets
  l.scan(/\w+/).each{|w| h[w] +=1 }
end

h.keys.sort.each{|k| puts "#{k}\t#{h[k]}"}
