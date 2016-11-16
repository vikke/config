#!/usr/bin/env ruby
require 'pp'

FILE='./log/development.log'

lines = []
q = []
h = nil

File.read(FILE).each_line do |l|
  if l =~  /  Parameters: {"utf8"=>/
    lines << l.sub(/  Parameters: /, '')
    h = q[0]
  end

  q.push(l)
  if q.length > 2
    q.shift
  end
end

File.open('last_query.log', 'w') do |fp|
  fp.write(h)
  PP.pp(eval(lines.last), fp)
end
