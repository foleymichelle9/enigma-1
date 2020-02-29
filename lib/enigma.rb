require_relative 'encrypt'
require_relative 'decrypt'
require 'date'

class Enigma

  def encrypt(message, key = nil, date = nil)
    @encrypt = Encrypt.new
    @encrypt.encrypt(message, key, date)
  end

  def decrypt(message, key, date = nil)
    @decrypt = Decrypt.new
    @decrypt.decrypt(message, key, date)
  end
end
