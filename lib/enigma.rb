require_relative 'encrypt'
require_relative 'decrypt'
require 'date'

class Enigma

  def encrypt(message, key = nil, date = nil)
    encryption = Encrypt.new
    encryption.encrypt(message, key, date)
  end

  def decrypt(message, key, date = nil)
    decryption = Decrypt.new
    decryption.decrypt(message, key, date)
  end
end
