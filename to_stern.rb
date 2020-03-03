require './dex.rb'
require './dex_maker.rb'

class ToStern
  include Dex
  include DexMaker
  @pool = []

  Dex::pokedex.select do |num, entry|
    if entry[1] != "3" && entry[0].split("").pop.match?(/["^"|!|#]/) == false
      @pool << entry
    end
  end

  @proto_dex = DexMaker::create_dex(@pool,20)

  File.open('./to_stern.txt', 'w') do |new_dex|
    @proto_dex.each do |entry|
      (0...entry.size).each do
        new_dex.print("#{entry.shift}-")
      end
      new_dex.puts
    end
  end
end
