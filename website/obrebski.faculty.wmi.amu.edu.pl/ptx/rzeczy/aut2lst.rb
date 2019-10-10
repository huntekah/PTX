#!/usr/bin/ruby1.9.1

$t=[]
$fin=[]
$max=0

while l=gets
  l.chomp!
  if l =~ /^\s*(\d+)\s*$/
    $fin << $1.to_i
  elsif l =~ /\s*(\d+)\s+(\d+)\s+(\S+)/
    $t[$1.to_i] = [] unless $t[$1.to_i]
    $t[$1.to_i][$2.to_i] = $3
    $max = $2.to_i if $max < $2.to_i
  end
end


def f(i,s)
  if $fin.member?(i)
    print s,"\n"
  end

  for j in 0..$max
    if $t[i] && $t[i][j]
      f(j,s+$t[i][j])
    end
  end

end

f(0,'')
