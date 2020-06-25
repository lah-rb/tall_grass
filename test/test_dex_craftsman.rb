require 'test_helper'
require 'fileutils'
require_relative'../dex_craftsman.rb'

class TestDexCraftsman < Minitest::Test
  def setup
    @seed = ["test", [111, 222, 333, 444, 555, 666, 777, 888], 10, "Proc.new { |dex| dex[2].to_i == 1 || dex[2].to_i == 3 }", ["dark", "|", "dragon"], "y"]
  end

  def teardown
    FileUtils.rm('./dex_store/test_dex')
  end

  def test_sucessful_craft
    assert DexCraftsman.new(@seed)
  end
end
