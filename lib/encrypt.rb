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
end
