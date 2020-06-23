module Dex

  def compile_dex(path)
    @pokedex = []
    File.open(path, "r") do |entry|
      while record = entry.gets
        @info = record.chomp.split('-')
        @pokedex << @info
      end
    end
    @pokedex
  end
  module_function :compile_dex

  def pokedex
    compile_dex("./dex_store/pokedex")
  end
  module_function :pokedex
end
