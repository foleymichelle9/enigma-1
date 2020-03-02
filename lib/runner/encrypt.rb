require_relative '../enigma'

enigma = Enigma.new

ARGV == ["message.txt", "encrypted.txt"]
input = ARGV

write_message = File.open('./lib/runner/message.txt', "w")
write_message.write("hello world")
write_message.close

read_message = File.open('./lib/runner/message.txt', "r")
message = read_message.read

write_encryption = File.open('./lib/runner/encrypted.txt', "w")
