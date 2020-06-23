require 'test_helper'
require 'fileutils'
require_relative '../dex.rb'
require_relative'../dex_maker.rb'

# seed equalivant: ["test", [111, 222, 333, 444, 555, 666, 777, 888], 10, "Proc.new { |dex| dex[2].to_i == 1 || dex[2].to_i == 3 }", ["dark", "|", "dragon"], "y"]

class TestDexMakerFull < Minitest::Test
  def setup
    @types_arr = ["Grass", "Poison", "Fire", "Water", "Bug", "Normal",
       "Electric", "Ground", "Fairy", "Fighting", "Psychic", "Rock",
        "Ghost", "Ice", "Dragon", "Dark", "Steel", "Flying"]
    @dex = Dex::pokedex
    @specific = [111, 222, 333, 444, 555, 666, 777, 888]
    @specific.map! { |num| @dex[num-1] }
    @size =  15
    @evo = "Proc.new { |dex| dex[2].to_i == 1 || dex[2].to_i == 3 }"
    @types = ["dark", "|", "dragon"]
    @legend = "y"
    @store = "./dex_store/test_dex"
    @filtered = DexMaker.filter_dex(@dex, eval(@evo), @types, @legend)
    if @filtered[-1][0].class == Array
      @leg_hold = @filtered.pop
      @specific += @leg_hold
    end
  end

  def prep_dex
    DexMaker.create_dex(@filtered, @store, @specific, @size)
    @store_arr = File.open(@store, 'r').readlines
    @store_arr.map! { |a| a.chomp.split('-') }
    @rand_arr = @store_arr.reject { |item| [111, 222, 333, 444, 555, 666, 777, 888].include?(item[0].to_i)  }
    @spec_arr = @store_arr-@rand_arr
    File.open(@store, 'r').close
    @file_size = @store_arr.size
  end

  def test_filtration
    refute_nil @leg_hold
    @filtered.each do |entry|
      assert entry[0].to_i
      assert_includes [1, 3], entry[2].to_i
      assert_includes  [entry[3], entry[4]], 'Dark'
      refute_includes [entry[3], entry[4]], 'Dragon'
    end
  end

  def test_good_dex
    prep_dex
    assert_equal 15, @file_size

    @store_arr.each do |entry|
      assert entry[0].to_i
      assert_operator entry[2].to_i, :<, 4
      assert_includes @types_arr, entry[3]
      assert_includes @types_arr << "%", entry[4]
      @types_arr.pop
    end

    @spec_arr.each do |entry|
      assert_includes [111, 222, 333, 444, 555, 666, 777, 888], entry[0].to_i
    end

    assert @rand_arr.any? { |entry| entry[1].match?(/["^"|!|#]/) }
    @rand_arr.each do |entry|
      assert_includes [1, 3], entry[2].to_i
      assert_includes  [entry[3], entry[4]], 'Dark'
      refute_includes [entry[3], entry[4]], 'Dragon'
    end
    FileUtils.rm('./dex_store/test_dex')
  end
end
