require 'date'

class Enigma

  def encrypt(message, key = nil, date = nil)
  @message = message
  @key = key
  @date = date
  encryption_hash_creation(@message)
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
    characters = message.split('')

    indices = []
    characters.each do |character|
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

  def add_shift_to_indices(message)
    slices = []
    sliced = slice_indices(message)
    sliced.map do |slice|
      slices << slice[0] + find_shifts[:a_shift] if !slice[0].nil?
      slices << slice[1] + find_shifts[:b_shift] if !slice[1].nil?
      slices << slice[2] + find_shifts[:c_shift] if !slice[2].nil?
      slices << slice[3] + find_shifts[:d_shift] if !slice[3].nil?
    end
    slices
  end

  def indices_in_alphabet_array(message)
    add_shift_to_indices(message).map do |index|
       if index > 26
         index % 27
       else
         index
       end
     end
  end

  def find_encryted_letters(message)
    letters = []

    indices_in_alphabet_array(message).each do |index|
      letters << alphabet[index]
    end
    letters.join
  end

  def encryption_hash_creation(message)
    encryption_hash = {}
    encryption_hash[:encryption] = find_encryted_letters(message)
    encryption_hash[:key] = @key
    encryption_hash[:date] = @date
    encryption_hash
  end
#==================================DECRYPTION===================================
  def subtract_shift_from_indices(message)
    slices = []
    sliced = slice_indices(message)
    sliced.map do |slice|
      slices << slice[0] - find_shifts[:a_shift] if !slice[0].nil?
      slices << slice[1] - find_shifts[:b_shift] if !slice[1].nil?
      slices << slice[2] - find_shifts[:c_shift] if !slice[2].nil?
      slices << slice[3] - find_shifts[:d_shift] if !slice[3].nil?
    end
    slices
  end

  def decryption_indices_in_alphabet_array(message)
    subtract_shift_from_indices(message).map do |index|
       if index < -26
         index % 27
       elsif index > -26 && index.negative?
         27 - index.abs
       else
         index
       end
     end
  end

end
