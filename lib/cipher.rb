class Cipher
  def initialize
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

  def find_keys
    @key = generate_random_key if @key.nil?

    keys = {}
    keys[:a_key] = @key.to_s[0..1].to_i
    keys[:b_key] = @key.to_s[1..2].to_i
    keys[:c_key] = @key.to_s[2..3].to_i
    keys[:d_key] = @key.to_s[3..4].to_i
    keys
  end
end
