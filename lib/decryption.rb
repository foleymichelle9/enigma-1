require_relative 'cipher'

class Decryption < Cipher

  def decrypt(message, key, date = nil)
    @date = date
    decryption_hash_creation(message)
  end

  def subtract_shift_from_indices(message, key)
    slices = []
    sliced = slice_indices(message)
    sliced.map do |slice|
      slices << slice[0] if !slice[0].nil? && !slice[0].is_a?(Numeric)
      slices << slice[0] - find_shifts(key)[:a_shift] if !slice[0].nil? && slice[0].is_a?(Numeric)
      slices << slice[1] if !slice[1].nil? && !slice[1].is_a?(Numeric)
      slices << slice[1] - find_shifts(key)[:b_shift] if !slice[1].nil? && slice[1].is_a?(Numeric)
      slices << slice[2] if !slice[2].nil? && !slice[2].is_a?(Numeric)
      slices << slice[2] - find_shifts(key)[:c_shift] if !slice[2].nil? && slice[2].is_a?(Numeric)
      slices << slice[3] if !slice[3].nil? && !slice[3].is_a?(Numeric)
      slices << slice[3] - find_shifts(key)[:d_shift] if !slice[3].nil? && slice[3].is_a?(Numeric)
    end
    slices
  end

  def decryption_indices_in_alphabet_array(message, key)
    subtract_shift_from_indices(message, key).map do |index|
      if index.is_a?(Numeric) && index < -26
        index % 27
      elsif index.is_a?(Numeric) && index > -26 && index.negative?
        27 - index.abs
      else
        index
      end
    end
  end

  def find_decrypted_letters(message, key)
    find_letters(decryption_indices_in_alphabet_array(message, key))
  end

  def decryption_hash_creation(message)
    hash_creation("decryption", find_decrypted_letters(message))
  end
end
