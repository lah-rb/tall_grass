module Dex
  @pokedex = []

  File.open("./dex_store/pokedex.txt", "r") do |entry|
    while record = entry.gets
      @info = record.chomp.split('-')
      @pokedex << @info
    end
  end

  def self.pokedex
    @pokedex
  end
end
