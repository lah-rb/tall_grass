require 'test_helper'
require 'fileutils'
require_relative '../backend/dex_craftsman.rb'
require_relative '../backend/evo.rb'

class TestDexCraftsman < Minitest::Test
  prepend FileUtils
  Island = Struct.new(:name, :specific, :abundance, :evo, :type, :distinct, :priority)

  def setup
    @seed = Island.new(
      "test", [111, 222, 333, 444, 555, 666, 777, 888], 10,
       Evo.new([1,3]), ["dark", "|", "dragon"], [false, /[!|"^"]/, /[*|~|#]/], 'd'
     )
  end

  def teardown
    rm('./dex_store/test_dex')
  end

  def test_sucessful_craft
    assert DexCraftsman.new(@seed)
  end
end
