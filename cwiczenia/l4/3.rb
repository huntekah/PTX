
defy = {}

def apply defs, line
  begin
    cont = false
    for k,v in defs
      unless line.scan(k).empty?
        line.sub!(k,v)
        cont = true
        break
      end
    end
  end while cont
  line
end

while l=gets
  case l
  when /^\s*#define\s+(\S+)\s*(.*)$/
    defy[$1] = $2
  else
    puts apply(defy,l)
  end
end
