require 'json'
require 'msgpack'
require 'pry-byebug'


hoge = MessagePack.unpack(File.read(ARGV[0])).map do |m|
  v = Zlib.inflate(m['compressed_expression'])
  m['compressed_expression'] = v
  m
end

hoge.each do |h|
  puts h['constraintid']
  puts h if h['constraintid'] == 'constraint_for_6733'
end



#puts JSON.dump(hoge)
