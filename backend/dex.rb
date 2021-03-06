module Dex
  Entry = Struct.new(:num, :name, :evo, :prime_type, :second_type)

  def compile_dex(path, special_dex = false)
    File.open(path, "r") do |file_dex|
      file_dex.reduce([]) do |exec_dex, line|
        @number, @name, @evolution_stage, @primary_type, @secondary_type \
        = line.chomp.split('-')

        @new_page = Entry.new(
          @number.to_i, @name, @evolution_stage.to_i, @primary_type, @secondary_type
        )

        exec_dex.push(@new_page) unless special_dex
        exec_dex.push(line.chomp.split('-')) if special_dex
        exec_dex
      end
    end
  end
  module_function :compile_dex

  def entry(num, name, evo, prime, second)
    Entry.new(num.to_i, name, evo.to_i, prime, second)
  end
  module_function :entry

  def pokedex
    compile_dex("./dex_store/pokedex")
  end
  module_function :pokedex
end
