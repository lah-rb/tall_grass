module Dex
  @pokedex = []

  def self.compile_dex(path)
    File.open(path, "r") do |entry|
      while record = entry.gets
        @info = record.chomp.split('-')
        @pokedex << @info
      end
    end
    @pokedex
  end

  def self.pokedex
    self.compile_dex("./dex_store/pokedex.txt")
  end
end
