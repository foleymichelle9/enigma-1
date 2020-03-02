ARGV == ["message.txt", "encrypted.txt"]
input = ARGV
write_message = File.open('./lib/runner/message.txt', "w")
write_message.write("hello world")
write_message.close
