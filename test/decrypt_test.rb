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
end
