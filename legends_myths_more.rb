require './dex.rb'
require './dex_maker.rb'

class LegendsMythsMore
  include Dex
  include DexMaker
  @pool = []

  Dex::pokedex.select do |num, entry|
    if entry[0].split("").pop.match?(/["^"|!|#]/) == true
      @pool << entry
    end
  end

  DexMaker::create_dex(@pool,'./dex_store/legends_myths_more.txt',[],5)

end