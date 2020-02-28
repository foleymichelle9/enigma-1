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

  def generate_random_key
    five_random_digits = (0..9).to_a.sample(5)
    five_random_digits.join.to_i
  end

end
