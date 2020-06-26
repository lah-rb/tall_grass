require_relative "dex_maker_toolbox.rb"
require_relative "dex.rb"

class DexCraftsman
  include Dex
  include DexMakerToolbox

  def initialize(attr_arr)
    determine_area_qualities(attr_arr)
    explore_area
    set_dex
  end

  private

  def determine_area_qualities(attr_arr)
    @area_qualities = attr_arr
  end

  def explore_area
    @dex = Dex.pokedex
    @pool = []

    @area_name =  @area_qualities[0] #String no spaces
    @dex_file = './dex_store/' + @area_name + "_dex" #String
    @specific = @area_qualities[1] #Array or false
    @specific.map! { |num| @dex[num-1] }
    @size = @area_qualities[2] #Integer or false
    @evo =  eval(@area_qualities[3]) #Proc or false in String
    @types = @area_qualities[4] #Array or false
    @legend = @area_qualities[5] #String
  end

  def set_dex
    @pool = DexMakerToolbox.filter_dex(@dex, @evo, @types, @legend)
    if @pool[-1][0].class == Dex::Entry
      @legend_pool = @pool.pop
      if @legend_pool.size <= 3
        @specific += @legend_pool
      elsif @legend_pool.size > 3
        @specific += DexMakerToolbox.limit_pool(@legend_pool, rand(1..3))
      end
    end

    if @size == 0
      DexMakerToolbox.create_dex(@pool, @dex_file, @specific)
    else
      DexMakerToolbox.create_dex(@pool, @dex_file, @specific, @size)
    end
  end
end
