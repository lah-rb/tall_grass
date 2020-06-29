require_relative "dex_maker_toolbox.rb"
require_relative "dex.rb"

class DexCraftsman
  include Dex
  include DexMakerToolbox

  def initialize(area)
    @area = area
    setup_workbench
    fill_and_bind_dex
  end

  private

  def setup_workbench
    @dex = Dex.pokedex
    @pool = []
    @dex_file = './dex_store/' + @area.name + "_dex" #String
    @area.specific.map! { |num| @dex[num-1] }
  end

  def fill_and_bind_dex
    @pool = DexMakerToolbox.filter_dex(@dex, @area.evo, @area.type, @area.legend)

    if @pool[-1].class == Array
      @legend_pool = @pool.pop
      if @legend_pool.size <= 3
        @area.specific += @legend_pool
      elsif @legend_pool.size > 3
        @area.specific += DexMakerToolbox.limit_pool(@legend_pool, rand(1..3))
      end
    end

    if @size == 0
      DexMakerToolbox.create_dex(@pool, @dex_file, @area.specific)
    else
      DexMakerToolbox.create_dex(@pool, @dex_file, @area.specific, @area.abundance)
    end
  end
end
