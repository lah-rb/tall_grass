require "./dex_maker.rb"
require "./dex.rb"

class ExploreArea
  include DexMaker
  include Dex

  def initialize (attr_arr)
    @attr_arr = attr_arr
  end

  def set_location
    @dex = Dex::pokedex
    @pool = []

    @area_name =  @attr_arr[0].chomp.downcase.split(" ").join("_")
    @specific = @attr_arr[1] # line 1: Array or false
    @specific.map! { |num| @dex[num-1] }
    @dex_file = $store + @area_name + "_dex" # line 2: String

    @size = @attr_arr[2] # line 3: Integer or false
    @evo =  @attr_arr[3] # line 4: Proc or false
    @types = @attr_arr[4] # line 5: Array or false
    @legend = @attr_arr[5] # line 6: Booleon or nil
  end

  def set_dex
    @pool = DexMaker::filter_dex(@dex, @evo, @types, @legend)
    if @size == 0
      DexMaker::create_dex(@pool, @dex_file, @specific)
    else
      DexMaker::create_dex(@pool, @dex_file, @specific, @size)
    end
  end
end
