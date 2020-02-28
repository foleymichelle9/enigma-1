require 'date'

class Enigma

  def encrypt(message, key = nil, date = nil)
  @message = message
  @key = key
  @date = date
  end

  def alphabet
  ("a".."z").to_a << " "
  end
end
