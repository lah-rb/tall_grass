require 'test_helper'
require 'fileutils'
require_relative '../dir_manager.rb'
require_relative '../backend/dex.rb'

class TestDex < Minitest::Test
  prepend FileUtils

  def setup
    DirManager.new('backend')
  end

  def test_dex_has_entries
    assert Dex.pokedex[0]
    assert Dex.pokedex[889]
    refute Dex.pokedex[890]
  end
end
