require_relative 'test_helper'
require 'mocha/minitest'
require './lib/encryption'
require 'date'

class EncryptionTest < Minitest::Test
  def setup
    @encryption = Encryption.new
  end

  def test_it_exists
    assert_instance_of Encryption, @encryption
  end

  def test_it_can_return_alphabet_array
    expected =  [
      "a",
      "b",
      "c",
      "d",
      "e",
      "f",
      "g",
      "h",
      "i",
      "j",
      "k",
      "l",
      "m",
      "n",
      "o",
      "p",
      "q",
      "r",
      "s",
      "t",
      "u",
      "v",
      "w",
      "x",
      "y",
      "z",
      " "
    ]

    assert_equal expected, @encryption.alphabet
  end

  def test_it_can_find_keys
    # @encryption.stubs(:generate_random_key).returns("02715")
    expected = {
      :a_key=>2,
      :b_key=>27,
      :c_key=>71,
      :d_key=>15
    }

    assert_equal expected, @encryption.find_keys("02715")
  end

  def test_it_can_find_offsets
    Date.stubs(:today).returns(Date.new(1995, 8, 4))
    expected = {
      :a_offset=>1,
      :b_offset=>0,
      :c_offset=>2,
      :d_offset=>5
    }

    assert_equal expected, @encryption.find_offsets
  end

  def test_it_can_find_shifts
    Date.stubs(:today).returns(Date.new(1995, 8, 4))
    # @encryption.stubs(:generate_random_key).returns("02715")
    expected = {
      :a_shift=>3,
      :b_shift=>27,
      :c_shift=>73,
      :d_shift=>20
    }

    assert_equal expected, @encryption.find_shifts("02715")
  end

  def test_it_can_find_message_indices
    expected = [7, 4, 11, 11, 14, 26, 22, 14, 17, 11, 3]
    sym_expected = ["!", 7, 4, 11, 11, 14, "!", 26, 22, 14, 17, 11, 3, "!"]

    assert_equal expected, @encryption.find_message_indices("hello world")
    assert_equal expected, @encryption.find_message_indices("HELLO WORLD")
    assert_equal sym_expected, @encryption.find_message_indices("!HELLO! WORLD!")
  end

  def test_it_can_slice_indices
    expected = [[7, 4, 11, 11], [14, 26, 22, 14], [17, 11, 3]]
    sym_expected = [["!", 7, 4, 11], [11, 14, "!", 26], [22, 14, 17, 11], [3, "!"]]

    assert_equal expected, @encryption.slice_indices("hello world")
    assert_equal expected, @encryption.slice_indices("HELLO WORLD")
    assert_equal sym_expected, @encryption.slice_indices("!HELLO! WORLD!")
  end

  def test_it_can_add_shift_to_indices
    Date.stubs(:today).returns(Date.new(1995, 8, 4))
    @encryption.stubs(:generate_random_key).returns("02715")
    expected = [10, 31, 84, 31, 17, 53, 95, 34, 20, 38, 76]
    sym_expected = ["!", 34, 77, 31, 14, 41, "!", 46, 25, 41, 90, 31, 6, "!"]

    assert_equal expected, @encryption.add_shift_to_indices("hello world")
    assert_equal expected, @encryption.add_shift_to_indices("HELLO WORLD")
    assert_equal sym_expected, @encryption.add_shift_to_indices("!HELLO! WORLD!")
  end

  def test_it_can_find_encryption_indices_in_alphabet_array_range
    Date.stubs(:today).returns(Date.new(1995, 8, 4))
    @encryption.stubs(:generate_random_key).returns("02715")
    expected = [10, 4, 3, 4, 17, 26, 14, 7, 20, 11, 22]
    sym_expected = ["!", 7, 23, 4, 14, 14, "!", 19, 25, 14, 9, 4, 6, "!"]

    assert_equal expected, @encryption.encryption_indices_in_alphabet_array("hello world")
    assert_equal expected, @encryption.encryption_indices_in_alphabet_array("HELLO WORLD")
    assert_equal sym_expected, @encryption.encryption_indices_in_alphabet_array("!HELLO! WORLD!")
  end

  def test_it_can_find_encryted_letters
    Date.stubs(:today).returns(Date.new(1995, 8, 4))
    @encryption.stubs(:generate_random_key).returns("02715")

    assert_equal "keder ohulw", @encryption.find_encryted_letters("hello world")
    assert_equal "keder ohulw", @encryption.find_encryted_letters("HELLO WORLD")
    assert_equal "!hxeoo!tzojeg!", @encryption.find_encryted_letters("!HELLO! WORLD!")
  end

  def test_it_can_create_encryption_hash_creation
    Date.stubs(:today).returns(Date.new(1995, 8, 4))
    @encryption.stubs(:generate_random_key).returns("02715")
    expected = {
      :encryption=>"keder ohulw",
      :key=>"02715",
      :date=>"040895"
    }
    sym_expected = {
      :encryption=>"!hxeoo!tzojeg!",
      :key=>"02715",
      :date=>"040895"
    }

    assert_equal expected, @encryption.encryption_hash_creation("hello world")
    assert_equal expected, @encryption.encryption_hash_creation("HELLO WORLD")
    assert_equal sym_expected, @encryption.encryption_hash_creation("!HELLO! WORLD!")
  end

  def test_test_it_can_encrypt_message_with_key_and_date
    expected = {
        encryption: "keder ohulw",
        key: "02715",
        date: "040895"
      }

    assert_equal expected, @encryption.encrypt("hello world", "02715", "040895")
    assert_equal expected, @encryption.encrypt("HELLO WORLD", "02715", "040895")
  end

  def test_it_can_encrypt_message_with_key
    Date.stubs(:today).returns(Date.new(2020, 2, 28))
    expected = {
        encryption: "rib ydmcapu",
        key: "02715",
        date: "280220"
      }
    encrypted = @encryption.encrypt("hello world", "02715")
    encrypted = @encryption.encrypt("HELLO WORLD", "02715")

    assert_equal expected, encrypted
  end

  def test_it_can_encrypt_message_with_random_key
    @encryption.stubs(:generate_random_key).returns("02715")
    Date.stubs(:today).returns(Date.new(1995, 8, 4))
    expected = {
        encryption: "keder ohulw",
        key: "02715",
        date: "040895"
      }

    assert_equal expected, @encryption.encrypt("hello world")
    assert_equal expected, @encryption.encrypt("HELLO WORLD")
  end
end
