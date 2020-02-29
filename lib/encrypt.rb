require_relative 'cipher'

class Encrypt < Cipher
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

  def encryption_indices_in_alphabet_array(message)
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

    encryption_indices_in_alphabet_array(message).each do |index|
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
end
