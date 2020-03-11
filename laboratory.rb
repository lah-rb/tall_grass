require './area_maker.rb'

class LegendsMythsMore
  include AreaMaker
  @pool = []
  @specific = []
  @file = AreaMaker::store + "laboratory.txt"
  @dex = Dex::pokedex
  @evo = false
  @types = %w[psychic]
  @legend = true

  # Filter_dex expects(dex array, evo proc, types array, legend booleon)
  @pool = DexMaker::filter_dex(@dex, @evo, @types, @legend)

  DexMaker::create_dex(@pool, @file, @specific,20)
end
