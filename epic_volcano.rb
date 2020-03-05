require './area_maker.rb'

class EpicVolcano
  include AreaMaker
  @pool = []
  @file = AreaMaker::store + "epic_volcano.txt"

  Dex::pokedex.select do |num, entry|
    if entry[0].split("").pop.match?(/["^"|!|#]/) == false
      @pool << entry
    end
  end

  DexMaker::create_dex(@pool,@file, %w[fire rock ground dark])

end
