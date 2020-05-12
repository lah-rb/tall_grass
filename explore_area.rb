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

    @area_name =  @attr_arr[0] #String no spaces
    @dex_file = $store + @area_name + "_dex" #String
    @specific = @attr_arr[1] #Array or false
    @specific.map! { |num| @dex[num-1] }
    @size = @attr_arr[2] #Integer or false
    @evo =  eval(@attr_arr[3]) #Proc or false in String
    @types = @attr_arr[4] #Array or false
    @legend = @attr_arr[5] #Booleon or nil
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
