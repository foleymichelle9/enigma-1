require_relative '../enigma'

enigma = Enigma.new

input = ARGV

read_message = File.open('./lib/runner/message.txt', "r")
message = read_message.read

encrypted_message = enigma.encrypt(message)

write_encryption = File.open('./lib/runner/encrypted.txt', "w")
write_encryption.write(encrypted_message[:encryption])
write_encryption.close

File.open('./lib/runner/encrypted.txt', "r")

puts "Created #{input[1]} with the key #{encrypted_message[:key]} and date #{encrypted_message[:date]}."
