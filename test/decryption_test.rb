require_relative 'test_helper'
require 'mocha/minitest'
require './lib/decryption'
require './lib/encryption'
require 'date'

class DecryptionTest < Minitest::Test
  def setup
    @decryption = Decryption.new
    @encryption = Encryption.new
  end

  def test_it_exists
    assert_instance_of Decryption, @decryption
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

    assert_equal expected, @decryption.alphabet
  end

  def test_it_can_find_keys
    @decryption.stubs(:generate_random_key).returns("02715")
    expected = {
      :a_key=>2,
      :b_key=>27,
      :c_key=>71,
      :d_key=>15
    }

    assert_equal expected, @decryption.find_keys
  end

  def test_it_can_find_offsets
    Date.stubs(:today).returns(Date.new(1995, 8, 4))
    expected = {
      :a_offset=>1,
      :b_offset=>0,
      :c_offset=>2,
      :d_offset=>5
    }

    assert_equal expected, @decryption.find_offsets
  end

  def test_it_can_find_shifts
    Date.stubs(:today).returns(Date.new(1995, 8, 4))
    @decryption.stubs(:generate_random_key).returns("02715")
    expected = {
      :a_shift=>3,
      :b_shift=>27,
      :c_shift=>73,
      :d_shift=>20
    }

    assert_equal expected, @decryption.find_shifts
  end

  def test_it_can_find_message_indices
    expected = [10, 4, 3, 4, 17, 26, 14, 7, 20, 11, 22]
    sym_expected = ["!", 10, 4, 3, 4, 17, "!", 26,  14, 7, 20, 11, 22, "!"]

    assert_equal expected, @decryption.find_message_indices("keder ohulw")
    assert_equal sym_expected, @decryption.find_message_indices("!keder! ohulw!")
  end

  def test_it_can_slice_indices
    expected = [[10, 4, 3, 4], [17, 26, 14, 7], [20, 11, 22]]
    sym_expected = [["!", 10, 4, 3], [4, 17, "!", 26],  [14, 7, 20, 11], [22, "!"]]

    assert_equal expected, @decryption.slice_indices("keder ohulw")
    assert_equal expected, @decryption.slice_indices("KEDER OHULW")
    assert_equal sym_expected, @decryption.slice_indices("!keder! ohulw!")
  end

  def test_it_can_subtract_shifts_from_indices
    Date.stubs(:today).returns(Date.new(1995, 8, 4))
    @decryption.stubs(:generate_random_key).returns("02715")
    expected = [7, -23, -70, -16, 14, -1, -59, -13, 17, -16, -51]
    sym_expected = ["!", -17, -69, -17, 1, -10, "!", 6, 11, -20, -53, -9, 19, "!"]

    assert_equal expected, @decryption.subtract_shift_from_indices("keder ohulw")
    assert_equal expected, @decryption.subtract_shift_from_indices("KEDER OHULW")
    assert_equal sym_expected, @decryption.subtract_shift_from_indices("!keder! ohulw!")
  end

  def test_it_can_find_decryption_indices_in_alphabet_array
    Date.stubs(:today).returns(Date.new(1995, 8, 4))
    @decryption.stubs(:generate_random_key).returns("02715")
    expected = [7, 4, 11, 11, 14, 26, 22, 14, 17, 11, 3]
    sym_expected = ["!", 10, 12, 10, 1, 17, "!", 6, 11, 7, 1, 18, 19, "!"]

    assert_equal expected, @decryption.decryption_indices_in_alphabet_array("keder ohulw")
    assert_equal expected, @decryption.decryption_indices_in_alphabet_array("KEDER OHULW")
    assert_equal sym_expected, @decryption.decryption_indices_in_alphabet_array("!keder! ohulw!")
  end

  def test_it_can_find_decrypted_letters
    Date.stubs(:today).returns(Date.new(1995, 8, 4))
    @decryption.stubs(:generate_random_key).returns("02715")

    assert_equal "hello world", @decryption.find_decrypted_letters("keder ohulw")
    assert_equal "hello world", @decryption.find_decrypted_letters("KEDER OHULW")
    assert_equal "!hello! world!", @decryption.find_decrypted_letters("!hxeoo!tzojeg!")
  end

  def test_it_can_get_decryption_hash_creation
    Date.stubs(:today).returns(Date.new(1995, 8, 4))
    @decryption.stubs(:generate_random_key).returns("02715")
    expected = {
      decryption: "hello world",
      key: "02715",
      date: "040895"
    }
    sym_expected = {
      decryption: "!hello! world!",
      key: "02715",
      date: "040895"
    }

    assert_equal expected, @decryption.decryption_hash_creation("keder ohulw")
    assert_equal expected, @decryption.decryption_hash_creation("KEDER OHULW")
    assert_equal sym_expected, @decryption.decryption_hash_creation("!hxeoo!tzojeg!")
  end

  def test_it_can_decrypt_message_with_key_and_date
    expected = {
      decryption: "hello world",
      key: "02715",
      date: "040895"
    }
    sym_expected = {
      decryption: "!hello! world!",
      key: "02715",
      date: "040895"
    }

    assert_equal expected, @decryption.decrypt("keder ohulw", "02715", "040895")
    assert_equal expected, @decryption.decrypt("KEDER OHULW", "02715", "040895")
    assert_equal sym_expected, @decryption.decrypt(("!hxeoo!tzojeg!"), "02715", "040895")
  end

  def test_it_can_decrypt_message_with_key
    Date.stubs(:today).returns(Date.new(1995, 8, 4))
    encrypted = @encryption.encrypt("hello world", "02715")
    expected = {
      decryption: "hello world",
      key: "02715",
      date: "040895"
    }

    assert_equal expected, @decryption.decrypt(encrypted[:encryption], "02715")
  end
end
