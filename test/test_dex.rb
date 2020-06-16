require 'test_helper'
require_relative'../dex.rb'

class TestDex < Minitest::Test
  def test_dex_has_entries
    assert Dex::pokedex[0]
  end
end
