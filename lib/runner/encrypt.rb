require_relative '../enigma'

enigma = Enigma.new

ARGV == ["message.txt", "encrypted.txt"]
input = ARGV

# write_message = File.open('./lib/runner/message.txt', "w")
# write_message.write("hello world")
# write_message.close

read_message = File.open('./lib/runner/message.txt', "r")
message = read_message.read

encrypted_message = enigma.encrypt(message)

write_encryption = File.open('./lib/runner/encrypted.txt', "w")
write_encryption.write(encrypted_message[:encryption])
write_encryption.close

read_encryption = File.open('./lib/runner/encrypted.txt', "r")

puts "Created #{input[0]} with the key #{encrypted_message[:key]} and date #{encrypted_message[:date]}"
