require 'test_helper'
require 'fileutils'
require './backend/discover_area.rb'

class TestDiscoverArea < Minitest::Test
  Observations = Struct.new(:name, :specific, :abundance, :evo, :yes, :no, :baby, :fossil, :beast, :legend, :myth, :priority)

  def setup
    @obs = Observations.new("test", "111-222-333-444-555-666-777-888",
       "10", "1-3", "dark", "dragon","n", "n", "n", "y", "y", "")
    DiscoverArea.new(@obs)
    require "./dex_seeds/test.rb"
  end

  def teardown
    FileUtils.rm("./dex_seeds/test.rb")
    FileUtils.rm("./dex_store/test_dex")
    FileUtils.cd('..')
  end

  def test_good_seed
    assert_equal(
      ["test", [111, 222, 333, 444, 555, 666, 777, 888], 10, [1, 3],
      ["dark", "|", "dragon"], [false, /[!|"^"]/, /[*|~|#]/], "d"], NativeFruit.new.seed
    )
  end
end
