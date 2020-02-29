require_relative 'test_helper'
require 'mocha/minitest'
require './lib/encrypt'
require 'date'

class EncryptTest < Minitest::Test
  def setup
    @encrypt = Encrypt.new
  end

  def test_it_exists
    assert_instance_of Encrypt, @encrypt
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

    assert_equal expected, @encrypt.alphabet
  end

  def test_it_can_find_keys
    @encrypt.stubs(:generate_random_key).returns("02715")
    expected = {
      :a_key=>2,
      :b_key=>27,
      :c_key=>71,
      :d_key=>15
    }

    assert_equal expected, @encrypt.find_keys
  end

  def test_it_can_find_offsets
    Date.stubs(:today).returns(Date.new(1995, 8, 4))
    expected = {
      :a_offset=>1,
      :b_offset=>0,
      :c_offset=>2,
      :d_offset=>5
    }

    assert_equal expected, @encrypt.find_offsets
  end

  def test_it_can_find_shifts
    Date.stubs(:today).returns(Date.new(1995, 8, 4))
    @encrypt.stubs(:generate_random_key).returns("02715")
    expected = {
      :a_shift=>3,
      :b_shift=>27,
      :c_shift=>73,
      :d_shift=>20
    }

    assert_equal expected, @encrypt.find_shifts
  end

  def test_it_can_find_message_indices
    encryption_expected = [7, 4, 11, 11, 14, 26, 22, 14, 17, 11, 3]

    assert_equal encryption_expected, @encrypt.find_message_indices("hello world")
    assert_equal encryption_expected, @encrypt.find_message_indices("HELLO WORLD")
  end

  def test_it_can_slice_indices
    encryption_expected = [[7, 4, 11, 11], [14, 26, 22, 14], [17, 11, 3]]

    assert_equal encryption_expected, @encrypt.slice_indices("hello world")
    assert_equal encryption_expected, @encrypt.slice_indices("HELLO WORLD")
  end
end
