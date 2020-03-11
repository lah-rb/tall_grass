require './area_maker.rb'

class LandHoe
  include AreaMaker
  @pool = []
  @specific = [223, 602, 769]
  @file = AreaMaker::store + "land_hoe.txt"
  @dex = Dex::pokedex
  @evo = Proc.new { |dex| dex[2].to_i == 1 }
  @types = %w[rock water]
  @legend = false

  @specific.map! { |num| @dex[num-1] }

  # Filter_dex expects(dex array, evo proc, types array, legend booleon)
  @pool = DexMaker::filter_dex(@dex, @evo, @types, @legend)

  DexMaker::create_dex(@pool, @file, @specific, 8)
end
