require_relative 'test_helper'
require 'mocha/minitest'
require './lib/decrypt'
require 'date'

class DecryptTest < Minitest::Test
  def setup
    @encrypt = Encrypt.new
  end

  def test_it_exists
    assert_instance_of Encrypt, @encrypt
  end
end
