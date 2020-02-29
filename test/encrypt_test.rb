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
end
