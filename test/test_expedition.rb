require 'test_helper'
require 'fileutils'
require_relative '../dir_manager.rb'
require'./backend/expedition.rb'

class TestExpedition < Minitest::Test
  prepend FileUtils

  def setup
    DirManager.new('backend')
    @land_hoe = "./dex_store/land_hoe_dex"
    @original = "./dex_store/original"
    cp(@land_hoe, @original)
    @seed = 'land hoe'
  end

  def teardown
    cp(@original, @land_hoe)
    rm(@original)
  end

  def test_finds_area_again
    assert Expedition.new(@seed)
    refute_equal File.open(@original, 'r').readlines, File.open(@land_hoe, 'r').readlines
  end
end
