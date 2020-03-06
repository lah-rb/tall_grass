require './area_maker'

class LandHoe
  include AreaMaker
  @pool = []
  @file = AreaMaker::store + "land_hoe.txt"

  Dex::pokedex.select do |entry|
    if entry[2] == '1' && entry[1].split("").pop.match?(/["^"|!|#]/) == false
      @pool << entry
    end
  end

  DexMaker::create_dex(@pool,@file, %w[rock water])

end
