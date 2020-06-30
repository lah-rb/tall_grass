module Dex
  public
  Entry = Struct.new(:num, :name, :evo, :prime_type, :second_type)

  def compile_dex(path, special_dex = false)
    @pokedex = []
    File.open(path, "r") do |entry|
      while record = entry.gets
        @info = record.chomp.split('-')
        @new_page = Entry.new(@info[0].to_i, @info[1], @info[2].to_i, @info[3], @info[4])
        @pokedex << @new_page unless special_dex
        @pokedex << @info if special_dex
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
