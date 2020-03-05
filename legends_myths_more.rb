require './area_maker.rb'

class LegendsMythsMore
  include AreaMaker
  @pool = []
  @file = AreaMaker::store + "legends_myths_more.txt"

  Dex::pokedex.select do |num, entry|
    if entry[0].split("").pop.match?(/["^"|!|#]/) == true
      @pool << entry
    end
  end

  DexMaker::create_dex(@pool, @file,[],5)

end
