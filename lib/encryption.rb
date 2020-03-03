require_relative 'cipher'

class Encryption < Cipher

  def encrypt(message, key = nil, date = nil)
    key = generate_random_key if key.nil?
    date = Date.today.strftime('%d%m%y') if date.nil?
    encryption_hash_creation(message, key, date)
  end

  def add_shift_to_indices(message, key, date)
    slices = []
    sliced = slice_indices(message)
    sliced.map do |slice|
      slices << slice[0] if !slice[0].nil? && !slice[0].is_a?(Numeric)
      slices << slice[0] + find_shifts(key, date)[:a_shift] if !slice[0].nil? && slice[0].is_a?(Numeric)
      slices << slice[1] if !slice[1].nil? && !slice[1].is_a?(Numeric)
      slices << slice[1] + find_shifts(key, date)[:b_shift] if !slice[1].nil? && slice[1].is_a?(Numeric)
      slices << slice[2] if !slice[2].nil? && !slice[2].is_a?(Numeric)
      slices << slice[2] + find_shifts(key, date)[:c_shift] if !slice[2].nil? && slice[2].is_a?(Numeric)
      slices << slice[3] if !slice[3].nil? && !slice[3].is_a?(Numeric)
      slices << slice[3] + find_shifts(key, date)[:d_shift] if !slice[3].nil? && slice[3].is_a?(Numeric)
    end
    slices
  end

  def encryption_indices_in_alphabet_range(message, key, date)
    add_shift_to_indices(message, key, date).map do |index|
      if index.is_a?(Numeric) && index > 26
        index % 27
      else
        index
      end
    end
  end

  def encryted_letters(message, key, date)
    find_letters(encryption_indices_in_alphabet_range(message, key, date))
  end

  def encryption_hash_creation(message, key, date)
    hash_creation("encryption", encryted_letters(message, key, date), key, date)
  end
end
