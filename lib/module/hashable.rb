module Hashable
  def hash_creation(key1_name, collection, key)
    hash_name = {}
    hash_name[key1_name.to_sym] = collection
    hash_name[:key] = key
    hash_name[:date] = @date
    hash_name
  end
end
