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
    assert_equal [7, 4, 11, 11, 14, 26, 22, 14, 17, 11, 3], @enigma.find_message_indices("hello world")
    assert_equal [10, 4, 3, 4, 17, 26, 14, 7, 20, 11, 22], @enigma.find_message_indices("keder ohulw")
  end

  def test_it_can_slice_indices
    assert_equal [[7, 4, 11, 11], [14, 26, 22, 14], [17, 11, 3]], @enigma.slice_indices("hello world")
    assert_equal [[10, 4, 3, 4], [17, 26, 14, 7], [20, 11, 22]], @enigma.slice_indices("keder ohulw")
  end

  def test_it_can_add_shift_to_indices
    Date.stubs(:today).returns(Date.new(1995, 8, 4))
    @enigma.stubs(:generate_random_key).returns("02715")

    assert_equal [10, 31, 84, 31, 17, 53, 95, 34, 20, 38, 76], @enigma.add_shift_to_indices("hello world")
    assert_equal [13, 31, 76, 24, 20, 53, 87, 27, 23, 38, 95], @enigma.add_shift_to_indices("keder ohulw")
  end

  def test_it_can_find_indices_in_alphabet_array_range
    Date.stubs(:today).returns(Date.new(1995, 8, 4))
    @enigma.stubs(:generate_random_key).returns("02715")

    assert_equal [10, 4, 3, 4, 17, 26, 14, 7, 20, 11, 22], @enigma.indices_in_alphabet_array("hello world")
    assert_equal [13, 4, 22, 24, 20, 26, 6, 0, 23, 11, 14], @enigma.indices_in_alphabet_array("keder ohulw")
  end

  def test_it_can_find_encryted_letters
    Date.stubs(:today).returns(Date.new(1995, 8, 4))
    @enigma.stubs(:generate_random_key).returns("02715")

    assert_equal "keder ohulw", @enigma.find_encryted_letters("hello world")
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
  end

  def test_test_it_can_encrypt_message_with_key_and_date
    expected = {
        encryption: "keder ohulw",
        key: "02715",
        date: "040895"
      }

    assert_equal expected, @enigma.encrypt("hello world", "02715", "040895")
  end

  def test_it_can_encrypt_message_with_key
    Date.stubs(:today).returns(Date.new(2020, 2, 28))
    expected = {
        encryption: "rib ydmcapu",
        key: "02715",
        date: "280220"
      }
      encrypted = @enigma.encrypt("hello world", "02715")

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
  end
end
