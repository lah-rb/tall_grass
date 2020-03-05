module Dex
  @pokedex = {}

  File.open("./dex_store/pokedex.txt", "r") do |entry|
    while record = entry.gets
      @info = record.chomp.split('|')
      @info[1] = @info[1].split('-')
      @pokedex[@info[0]] = @info[1]
    end
  end

  def self.pokedex
    @pokedex
  end
end
