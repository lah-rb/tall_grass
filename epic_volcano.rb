require './dex.rb'
require './dex_maker.rb'

class EpicVolcano
  include Dex
  include DexMaker
  @pool = []

  Dex::pokedex.select do |num, entry|
    if entry[0].split("").pop.match?(/["^"|!|#]/) == false
      @pool << entry
    end
  end

  DexMaker::create_dex(@pool,20,'./epic_volcano.txt','Fire','Rock','Ground','Dark')

end
