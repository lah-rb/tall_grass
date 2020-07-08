require 'test_helper'
require 'fileutils'
require './backend/dex.rb'

class TestDex < Minitest::Test
  def setup
    FileUtils.cd('backend')
  end

  def teardown
    FileUtils.cd('..')
  end

  def test_dex_has_entries
    assert Dex.pokedex[0]
    assert Dex.pokedex[889]
    refute Dex.pokedex[890]
  end
end
