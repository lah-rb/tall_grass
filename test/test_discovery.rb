require 'test_helper'
require 'fileutils'
require './backend/discovery.rb'

class TestDiscovery < Minitest::Test
  prepend FileUtils
  Observations = Struct.new(:name, :specific, :abundance, :evo, :yes, :no, :baby, :fossil, :beast, :legend, :myth, :priority)

  def setup
    @obs = Observations.new("test", "111-222-333-444-555-666-777-888",
       "10", "1-3", "dark", "dragon","n", "n", "n", "y", "y", "")
    Discovery.new(@obs)
    require_relative "../backend/dex_seeds/test.rb"
  end

  def teardown
    rm("./dex_seeds/test.rb")
    rm("./dex_store/test_dex")
  end

  def test_good_seed
    assert_equal(
      ["test", [111, 222, 333, 444, 555, 666, 777, 888], 10, [1, 3],
      ["dark", "|", "dragon"], [false, /[!|"^"]/, /[*|~|#]/], "d"], NativeFruit.new.seed
    )
  end
end
