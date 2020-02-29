require_relative 'cipher'

class Decrypt < Cipher

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
