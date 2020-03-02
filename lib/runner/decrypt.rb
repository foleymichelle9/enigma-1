require_relative '../enigma'

enigma = Enigma.new

input = ARGV
decrypted_output = ARGV[1]
key = ARGV[2]
date = ARGV[3]

read_message = File.open('./lib/runner/encrypted.txt', "r")
message = read_message.read
