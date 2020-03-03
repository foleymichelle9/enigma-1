require_relative 'test_helper'
require 'mocha/minitest'
require './lib/decrypt'
require 'date'

class DecryptTest < Minitest::Test
  def setup
    @decrypt = Decrypt.new
  end

  def test_it_exists
    assert_instance_of Decrypt, @decrypt
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

    assert_equal expected, @decrypt.alphabet
  end

  def test_it_can_find_keys
    @decrypt.stubs(:generate_random_key).returns("02715")
    expected = {
      :a_key=>2,
      :b_key=>27,
      :c_key=>71,
      :d_key=>15
    }

    assert_equal expected, @decrypt.find_keys
  end

  def test_it_can_find_offsets
    Date.stubs(:today).returns(Date.new(1995, 8, 4))
    expected = {
      :a_offset=>1,
      :b_offset=>0,
      :c_offset=>2,
      :d_offset=>5
    }

    assert_equal expected, @decrypt.find_offsets
  end

  def test_it_can_find_shifts
    Date.stubs(:today).returns(Date.new(1995, 8, 4))
    @decrypt.stubs(:generate_random_key).returns("02715")
    expected = {
      :a_shift=>3,
      :b_shift=>27,
      :c_shift=>73,
      :d_shift=>20
    }

    assert_equal expected, @decrypt.find_shifts
  end

  def test_it_can_find_message_indices
    expected = [10, 4, 3, 4, 17, 26, 14, 7, 20, 11, 22]

    assert_equal expected, @decrypt.find_message_indices("keder ohulw")
  end

  def test_it_can_slice_indices
    expected = [[10, 4, 3, 4], [17, 26, 14, 7], [20, 11, 22]]

    assert_equal expected, @decrypt.slice_indices("keder ohulw")
  end

  def test_it_can_subtract_shifts_from_indices
    Date.stubs(:today).returns(Date.new(1995, 8, 4))
    @decrypt.stubs(:generate_random_key).returns("02715")
    expected = [7, -23, -70, -16, 14, -1, -59, -13, 17, -16, -51]

    assert_equal expected, @decrypt.subtract_shift_from_indices("keder ohulw")
    assert_equal expected, @decrypt.subtract_shift_from_indices("KEDER OHULW")
  end

  def test_it_can_find_decryption_indices_in_alphabet_array
    Date.stubs(:today).returns(Date.new(1995, 8, 4))
    @decrypt.stubs(:generate_random_key).returns("02715")
    expected = [7, 4, 11, 11, 14, 26, 22, 14, 17, 11, 3]

    assert_equal expected, @decrypt.decryption_indices_in_alphabet_array("keder ohulw")
    assert_equal expected, @decrypt.decryption_indices_in_alphabet_array("KEDER OHULW")
  end

  def test_it_can_find_decrypted_letters
    Date.stubs(:today).returns(Date.new(1995, 8, 4))
    @decrypt.stubs(:generate_random_key).returns("02715")

    assert_equal "hello world", @decrypt.find_decrypted_letters("keder ohulw")
    assert_equal "hello world", @decrypt.find_decrypted_letters("KEDER OHULW")
  end

  def test_it_can_get_decryption_hash_creation
    Date.stubs(:today).returns(Date.new(1995, 8, 4))
    @decrypt.stubs(:generate_random_key).returns("02715")
    expected = {
      decryption: "hello world",
      key: "02715",
      date: "040895"
    }

    assert_equal expected, @decrypt.decryption_hash_creation("keder ohulw")
    assert_equal expected, @decrypt.decryption_hash_creation("KEDER OHULW")
  end

  def test_it_can_decrypt_message_with_key_and_date
    expected = {
      decryption: "hello world",
      key: "02715",
      date: "040895"
    }

    assert_equal expected, @decrypt.decrypt("keder ohulw", "02715", "040895")
    assert_equal expected, @decrypt.decrypt("KEDER OHULW", "02715", "040895")
  end

  def test_it_can_decrypt_message_with_key
    Date.stubs(:today).returns(Date.new(1995, 8, 4))
    encrypted = @enigma.encrypt("hello world", "02715")
    expected = {
      decryption: "hello world",
      key: "02715",
      date: "040895"
    }

    assert_equal expected, @enigma.decrypt(encrypted[:encryption], "02715")
  end
end