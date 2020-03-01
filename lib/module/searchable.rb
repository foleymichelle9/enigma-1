module Searchable
  def find_letters(message, collection)
    letters = []

    collection(message).each do |index|
      if index.is_a?(Numeric)
        letters << alphabet[index]
      elsif !index.is_a?(Numeric)
        letters << index
      end
    end
    letters.join
  end
end
