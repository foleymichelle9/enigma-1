require_relative '../enigma'

enigma = Enigma.new

encrypted_input = ARGV[0]
decrypted_output = ARGV[1]
key = ARGV[2]
date = ARGV[3]

read_message = File.open(encrypted_input, "r")
message = read_message.read

decrypted_message = enigma.decrypt(message, key, date)

write_decryption = File.open(decrypted_output, "w")
write_decryption.write(decrypted_message[:decryption])
write_decryption.close

puts "Created #{decrypted_output} with the key #{key} and date #{date}."
