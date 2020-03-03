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

  @proto_dex = DexMaker::create_dex(@pool,20)

  File.open('./incubator_facility.txt', 'w') do |new_dex|
    @proto_dex.each do |entry|
      @line = ""
      (0...entry.size).each do
        @line = @line + entry.shift + "-"
      end
      new_dex.puts("#{@line.chop}")
    end
  end
end
