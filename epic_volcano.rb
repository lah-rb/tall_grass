require './area_maker.rb'

class EpicVolcano
  include AreaMaker
  @pool = []
  @file = AreaMaker::store + "epic_volcano.txt"
  @dex = Dex::pokedex
  @evo = false
  @types = %w[fire rock ground dark]
  @legend = false

  #filter_dex expects(dex array, evo proc, types array, legend booleon)
  @pool = DexMaker::filter_dex(@dex, @evo, @types, @legend)
  @pool = DexMaker::type_select(@pool, %w[water ice].unshift(false))

  DexMaker::create_dex(@pool, @file)
end
