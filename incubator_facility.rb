require './dex.rb'
require './dex_maker.rb'

class IncubatorFacility
  include Dex
  include DexMaker
  @pool = []

  Dex::pokedex.select do |num, entry|
    if entry[1] == "1" && entry[0].split("").pop.match?(/["^"|!|#]/) == false
      @pool << entry
    end
  end

  DexMaker::create_dex(@pool,20,'./incubator_facility.txt')

end
