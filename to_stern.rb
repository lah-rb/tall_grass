require './area_maker.rb'

class ToStern
  include AreaMaker
  @pool = []
  @file = AreaMaker::store + "to_stern.txt"

  Dex::pokedex.select do |entry|
    if entry[2].to_i == 1 && entry[1].split("").pop.match?(/["^"|!|#]/) == false
      @pool << entry
    end
  end
  DexMaker::create_dex(@pool,@file,[])
end
