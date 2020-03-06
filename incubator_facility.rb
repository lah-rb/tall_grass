require './area_maker.rb'

class IncubatorFacility
  include AreaMaker
  @pool = []
  @file = AreaMaker::store + "incubator_facility.txt"

  Dex::pokedex.select do |entry|
    if entry[2] == "1" && entry[1].split("").pop.match?(/["^"|!|#]/) == false
      @pool << entry
    end
  end
  DexMaker::create_dex(@pool,@file,[],20)
end
