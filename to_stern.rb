require './dex.rb'
require './dex_maker.rb'

class ToStern
  include Dex
  include DexMaker
  @pool = []

  Dex::pokedex.select do |num, entry|
    if entry[1].to_i == 1 && entry[0].split("").pop.match?(/["^"|!|#]/) == false
      @pool << entry
    end
  end

  DexMaker::create_dex(@pool,'./dex_store/to_stern.txt',[])
end
