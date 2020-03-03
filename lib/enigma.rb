require_relative 'encryption'
require_relative 'decryption'
require 'date'

class Enigma

  def encrypt(message, key = nil, date = nil)
    encryption = Encryption.new
    encryption.encrypt(message, key, date)
  end

  def decrypt(message, key, date = nil)
    decryption = Decryption.new
    decryption.decrypt(message, key, date)
  end
end
