require_relative 'test_helper'
require 'mocha/minitest'
require './lib/enigma'
require 'date'

class EnigmaTest < Minitest::Test
  def setup
    @enigma = Enigma.new
  end

  def test_it_exists
    assert_instance_of Enigma, @enigma
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

    assert_equal expected, @enigma.alphabet
  end

  def test_it_can_find_keys
    @enigma.stubs(:generate_random_key).returns("02715")
    expected = {
      :a_key=>2,
      :b_key=>27,
      :c_key=>71,
      :d_key=>15
    }

    assert_equal expected, @enigma.find_keys
  end

  def test_it_can_find_offsets
    Date.stubs(:today).returns(Date.new(1995, 8, 4))
    expected = {
      :a_offset=>1,
      :b_offset=>0,
      :c_offset=>2,
      :d_offset=>5
    }

    assert_equal expected, @enigma.find_offsets
  end

  def test_it_can_find_shifts
    Date.stubs(:today).returns(Date.new(1995, 8, 4))
    @enigma.stubs(:generate_random_key).returns("02715")
    expected = {
      :a_shift=>3,
      :b_shift=>27,
      :c_shift=>73,
      :d_shift=>20
    }

    assert_equal expected, @enigma.find_shifts
  end

  def test_it_can_find_message_indices
    encryption_expected = [7, 4, 11, 11, 14, 26, 22, 14, 17, 11, 3]
    decryption_expected = [10, 4, 3, 4, 17, 26, 14, 7, 20, 11, 22]

    assert_equal encryption_expected, @enigma.find_message_indices("hello world")
    assert_equal encryption_expected, @enigma.find_message_indices("HELLO WORLD")
    assert_equal decryption_expected, @enigma.find_message_indices("keder ohulw")
  end

  def test_it_can_slice_indices
    encryption_expected = [[7, 4, 11, 11], [14, 26, 22, 14], [17, 11, 3]]
    decryption_expected = [[10, 4, 3, 4], [17, 26, 14, 7], [20, 11, 22]]

    assert_equal encryption_expected, @enigma.slice_indices("hello world")
    assert_equal encryption_expected, @enigma.slice_indices("HELLO WORLD")
    assert_equal decryption_expected, @enigma.slice_indices("keder ohulw")
  end

  def test_it_can_add_shift_to_indices
    Date.stubs(:today).returns(Date.new(1995, 8, 4))
    @enigma.stubs(:generate_random_key).returns("02715")
    expected = [10, 31, 84, 31, 17, 53, 95, 34, 20, 38, 76]

    assert_equal expected, @enigma.add_shift_to_indices("hello world")
    assert_equal expected, @enigma.add_shift_to_indices("HELLO WORLD")
  end

  def test_it_can_find_indices_in_alphabet_array_range
    Date.stubs(:today).returns(Date.new(1995, 8, 4))
    @enigma.stubs(:generate_random_key).returns("02715")
    expected = [10, 4, 3, 4, 17, 26, 14, 7, 20, 11, 22]

    assert_equal expected, @enigma.indices_in_alphabet_array("hello world")
    assert_equal expected, @enigma.indices_in_alphabet_array("HELLO WORLD")
  end

  def test_it_can_find_encryted_letters
    Date.stubs(:today).returns(Date.new(1995, 8, 4))
    @enigma.stubs(:generate_random_key).returns("02715")

    assert_equal "keder ohulw", @enigma.find_encryted_letters("hello world")
    assert_equal "keder ohulw", @enigma.find_encryted_letters("HELLO WORLD")
  end

  def test_it_can_create_encryption_hash_creation
    Date.stubs(:today).returns(Date.new(1995, 8, 4))
    @enigma.stubs(:generate_random_key).returns("02715")
    expected = {
      :encryption=>"keder ohulw",
      :key=>"02715",
      :date=>"040895"
    }

    assert_equal expected, @enigma.encryption_hash_creation("hello world")
    assert_equal expected, @enigma.encryption_hash_creation("HELLO WORLD")
  end

  def test_test_it_can_encrypt_message_with_key_and_date
    expected = {
        encryption: "keder ohulw",
        key: "02715",
        date: "040895"
      }

    assert_equal expected, @enigma.encrypt("hello world", "02715", "040895")
    assert_equal expected, @enigma.encrypt("HELLO WORLD", "02715", "040895")
  end

  def test_it_can_encrypt_message_with_key
    Date.stubs(:today).returns(Date.new(2020, 2, 28))
    expected = {
        encryption: "rib ydmcapu",
        key: "02715",
        date: "280220"
      }
    encrypted = @enigma.encrypt("hello world", "02715")
    encrypted = @enigma.encrypt("HELLO WORLD", "02715")

    assert_equal expected, encrypted
  end

  def test_it_can_encrypt_message_with_random_key
    @enigma.stubs(:generate_random_key).returns("02715")
    Date.stubs(:today).returns(Date.new(1995, 8, 4))
    expected = {
        encryption: "keder ohulw",
        key: "02715",
        date: "040895"
      }

    assert_equal expected, @enigma.encrypt("hello world")
    assert_equal expected, @enigma.encrypt("HELLO WORLD")
  end
  #==================================DECRYPTION===================================

  def test_it_can_subtract_shifts_from_indices
    Date.stubs(:today).returns(Date.new(1995, 8, 4))
    @enigma.stubs(:generate_random_key).returns("02715")
    expected = [7, -23, -70, -16, 14, -1, -59, -13, 17, -16, -51]

    assert_equal expected, @enigma.subtract_shift_from_indices("keder ohulw")
    assert_equal expected, @enigma.subtract_shift_from_indices("KEDER OHULW")
  end

  def test_it_can_find_decryption_indices_in_alphabet_array
    Date.stubs(:today).returns(Date.new(1995, 8, 4))
    @enigma.stubs(:generate_random_key).returns("02715")
    expected = [7, 4, 11, 11, 14, 26, 22, 14, 17, 11, 3]

    assert_equal expected, @enigma.decryption_indices_in_alphabet_array("keder ohulw")
    assert_equal expected, @enigma.decryption_indices_in_alphabet_array("KEDER OHULW")
  end

  def test_it_can_find_decrypted_letters
    Date.stubs(:today).returns(Date.new(1995, 8, 4))
    @enigma.stubs(:generate_random_key).returns("02715")

    assert_equal "hello world", @enigma.find_decrypted_letters("keder ohulw")
    assert_equal "hello world", @enigma.find_decrypted_letters("KEDER OHULW")
  end

  def test_it_can_get_decryption_hash_creation
    Date.stubs(:today).returns(Date.new(1995, 8, 4))
    @enigma.stubs(:generate_random_key).returns("02715")
    expected = {
        decryption: "hello world",
        key: "02715",
        date: "040895"
      }

      assert_equal expected, @enigma.decryption_hash_creation("keder ohulw")
      assert_equal expected, @enigma.decryption_hash_creation("KEDER OHULW")
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

  def test_it_can_decrypt_message_with_key_and_date
    expected = {
      decryption: "hello world",
      key: "02715",
      date: "040895"
    }

    assert_equal expected, @enigma.decrypt("keder ohulw", "02715", "040895")
    assert_equal expected, @enigma.decrypt("KEDER OHULW", "02715", "040895")
  end
end
