require_relative 'test_helper'
require 'mocha/minitest'
require './lib/enigma'
require './lib/encrypt'
require 'date'

class EnigmaTest < Minitest::Test
  def setup
    @enigma = Enigma.new
    @encrypt = Encrypt.new
  end

  def test_it_exists
    assert_instance_of Enigma, @enigma
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

  def test_it_can_decrypt_message_with_key_and_date
    expected = {
      decryption: "hello world",
      key: "02715",
      date: "040895"
    }

    assert_equal expected, @enigma.decrypt("keder ohulw", "02715", "040895")
    assert_equal expected, @enigma.decrypt("KEDER OHULW", "02715", "040895")
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

  def test_it_can_encrypt_message_with_random_key
    @encrypt.stubs(:generate_random_key).returns("02715")
    Date.stubs(:today).returns(Date.new(1995, 8, 4))
    expected = {
        encryption: "keder ohulw",
        key: "02715",
        date: "040895"
      }

    assert_equal expected, @enigma.encrypt("hello world")
    assert_equal expected, @enigma.encrypt("HELLO WORLD")
  end
end
