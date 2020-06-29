require 'test_helper'
require 'fileutils'
require_relative '../discover_area.rb'

class TestDiscoverArea < Minitest::Test
  Observations = Struct.new(:name, :specific, :abundance, :evo, :yes, :no, :legend)

  def setup
    @obs = Observations.new("test", "111-222-333-444-555-666-777-888",
       "10", "1-3", "dark", "dragon", "y")
    DiscoverArea.new(@obs)
    require_relative "../dex_seeds/test.rb"
  end

  def teardown
    FileUtils.rm("./dex_seeds/test.rb")
    FileUtils.rm("./dex_store/test_dex")
  end

  def test_good_seed
    assert_equal(
      ["test", [111, 222, 333, 444, 555, 666, 777, 888], 10, [1, 3],
      ["dark", "|", "dragon"], "y"], NativeFruit.new.seed
    )
  end
end
