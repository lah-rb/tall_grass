require 'test_helper'
require 'fileutils'
require'./backend/rediscover_area.rb'

class TestRediscoverArea < Minitest::Test
  def setup
    FileUtils.cd('backend')
    @land_hoe = "./dex_store/land_hoe_dex"
    @original = "./dex_store/original"
    FileUtils.cp(@land_hoe, @original)
    FileUtils.cd('..')
    @seed = 'land hoe'
  end

  def teardown
    FileUtils.cp(@original, @land_hoe)
    FileUtils.rm(@original)
    FileUtils.cd('..')
  end

  def test_finds_area_again
    assert RediscoveredArea.new(@seed)
    refute_equal File.open(@original, 'r').readlines, File.open(@land_hoe, 'r').readlines
  end
end
