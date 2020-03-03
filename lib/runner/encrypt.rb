require_relative '../enigma'

enigma = Enigma.new

input = ARGV
message_to_read = input[0]

read_message = File.open(message_to_read, "r")
message = read_message.read

encrypted_message = enigma.encrypt(message)

write_encryption = File.open(input[1], "w")
write_encryption.write(encrypted_message[:encryption])
write_encryption.close

File.open(input[1], "r")

puts "Created #{input[1]} with the key #{encrypted_message[:key]} and date #{encrypted_message[:date]}."
