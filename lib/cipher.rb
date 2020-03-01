require "./lib/module/searchable"
require "./lib/module/hashable"

class Cipher
  include Searchable
  include Hashable

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

  def find_offsets
    @date = Date.today.strftime('%d%m%y') if @date.nil?
    date_squared = @date.to_i * @date.to_i
    last_four = date_squared.to_s[-4..-1]
    last_four = last_four

    offsets = {}
    offsets[:a_offset] = last_four[0].to_i
    offsets[:b_offset] = last_four[1].to_i
    offsets[:c_offset] = last_four[2].to_i
    offsets[:d_offset] = last_four[3].to_i
    offsets
  end

  def find_shifts
    shifts = {}
    shifts[:a_shift] = find_offsets[:a_offset] + find_keys[:a_key]
    shifts[:b_shift] = find_offsets[:b_offset] + find_keys[:b_key]
    shifts[:c_shift] = find_offsets[:c_offset] + find_keys[:c_key]
    shifts[:d_shift] = find_offsets[:d_offset] + find_keys[:d_key]
    shifts
  end

  def find_message_indices(message)
    characters = message.downcase.split('')

    indices = []
    characters.each do |character|
      if !character[/\W/].nil? && character != " "
        indices << character
      end
      alphabet.each do |letter|
        if character == letter
          indices << alphabet.index(letter)
        end
      end
    end
    indices
  end

  def slice_indices(message)
    find_message_indices(message).each_slice(4).to_a
  end
end
