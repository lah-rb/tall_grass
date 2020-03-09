require './area_maker.rb'

class LegendsMythsMore
  include AreaMaker
  @pool = []
  @file = AreaMaker::store + "laboratory.txt"
  @dex = Dex::pokedex
  @evo = false
  @types = %w[psychic]
  @legend = true

  #filter_dex expects(dex array, evo proc, types array, legend booleon)
  @pool = DexMaker::filter_dex(@dex, @evo, @types, @legend)

  DexMaker::create_dex(@pool, @file,20)
end
