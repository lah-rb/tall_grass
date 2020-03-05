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

  DexMaker::create_dex(@pool,'./dex_store/epic_volcano.txt', %w[fire rock ground dark])

end