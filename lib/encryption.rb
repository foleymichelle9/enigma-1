require_relative 'cipher'

class Encryption < Cipher

  def encrypt(message, key = nil, date = nil)
    @key = key
    @date = date
    encryption_hash_creation(message)
  end

  def add_shift_to_indices(message, key)
    slices = []
    sliced = slice_indices(message)
    sliced.map do |slice|
      slices << slice[0] if !slice[0].nil? && !slice[0].is_a?(Numeric)
      slices << slice[0] + find_shifts(key)[:a_shift] if !slice[0].nil? && slice[0].is_a?(Numeric)
      slices << slice[1] if !slice[1].nil? && !slice[1].is_a?(Numeric)
      slices << slice[1] + find_shifts(key)[:b_shift] if !slice[1].nil? && slice[1].is_a?(Numeric)
      slices << slice[2] if !slice[2].nil? && !slice[2].is_a?(Numeric)
      slices << slice[2] + find_shifts(key)[:c_shift] if !slice[2].nil? && slice[2].is_a?(Numeric)
      slices << slice[3] if !slice[3].nil? && !slice[3].is_a?(Numeric)
      slices << slice[3] + find_shifts(key)[:d_shift] if !slice[3].nil? && slice[3].is_a?(Numeric)
    end
    slices
  end

  def encryption_indices_in_alphabet_array(message)
    add_shift_to_indices(message).map do |index|
      if index.is_a?(Numeric) && index > 26
        index % 27
      else
        index
      end
    end
  end

  def find_encryted_letters(message)
    find_letters(encryption_indices_in_alphabet_array(message))
  end

  def encryption_hash_creation(message)
    hash_creation("encryption", find_encryted_letters(message))
  end
end
