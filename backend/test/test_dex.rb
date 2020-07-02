require 'test_helper'
require_relative'../dex.rb'

class TestDex < Minitest::Test
  def test_dex_has_entries
    assert Dex.pokedex[0]
    assert Dex.pokedex[889]
    refute Dex.pokedex[890]
  end
end
