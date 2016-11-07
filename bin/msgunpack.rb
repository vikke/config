require 'json'
require 'msgpack'

puts JSON.dump(MessagePack.unpack(File.read(ARGV[0])))
