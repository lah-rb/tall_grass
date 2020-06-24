require 'test_helper'
require 'fileutils'
require_relative'../discover_area.rb'

class TestDiscoverArea < Minitest::Test
  def setup
    @area_arr = ["test", "111-222-333-444-555-666-777-888",
       "10", "1-3", "dark", "dragon", "y"]
    DiscoverArea.new(@area_arr)
    File.open("./dex_seeds/test", "r") { |file| @attributes = file.gets }
  end

  def teardown
    FileUtils.rm("./dex_seeds/test")
    FileUtils.rm("./dex_store/test_dex")
  end

  def test_good_seed
    assert_equal(["test", [111, 222, 333, 444, 555, 666, 777, 888], 10,
       "Proc.new { |dex| dex.evo == 1 || dex.evo == 3 }",
        ["dark", "|", "dragon"], "y"], eval(@attributes))
  end
end
