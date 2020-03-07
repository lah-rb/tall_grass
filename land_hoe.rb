require './area_maker.rb'

class LandHoe
  include AreaMaker
  @pool = []
  @file = AreaMaker::store + "land_hoe.txt"
  @dex = Dex::pokedex
  @evo = Proc.new { |dex| dex[2].to_i == 1 }
  @types = %w[rock water]
  @legend = false

  #filter_dex expects(dex array, evo proc, types array, legend booleon)
  @pool = DexMaker::filter_dex(@dex, @evo, @type, @legend)

  DexMaker::create_dex(@pool, @file)
end
