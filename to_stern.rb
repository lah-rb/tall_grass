require './area_maker.rb'

class ToStern
  include AreaMaker
  @pool = []
  @file = AreaMaker::store + "to_stern.txt"
  @dex = Dex::pokedex
  @evo = Proc.new { |dex| dex[2].to_i == 1 }
  @types = false
  @legend = false

  #filter_dex expects(dex array, evo proc, types array, legend booleon)
  @pool = DexMaker::filter_dex(@dex, @evo, @types, @legend)

  DexMaker::create_dex(@pool, @file)
end
