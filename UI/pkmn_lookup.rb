require 'fileutils'
require_relative '../dex.rb'

class Lookup
  include Dex

  def name_or_num
    puts
    print 'Look up by name or number? (name/#) '
    $stdin.gets.downcase.chomp
  end

  def get_pkmn
    puts
    print 'What are you searching for? '
    $stdin.gets.capitalize.chomp
  end

  def make_output(num, name, evo, type_1, type_2)
    @info_string =
    "No. #{num.to_s} is \
    #{name} which is at evolution stage \
    #{evo.to_s} and is typed as \
    #{type_1}#{"-" + type_2 if type_2 != '%'}."
    return @info_string.split("  ").join
  end

  def look_in_dex(dex, search_means, seek)
    case search_means
    when 'name', 'nam'
      begin
        @pkmn = dex.select do |poke|
          if poke.name.match?(/["^"|!|#]/)
           poke.name.chop == seek
          else
           poke.name == seek
          end
        end
        @pkmn = @pkmn[0]
        puts
        puts make_output(@pkmn.num, @pkmn.name, @pkmn.evo,
           @pkmn.prime_type, @pkmn.second_type)
        puts
      rescue
        puts "That name does not exist. Please check for spelling."
        puts
        exit
      end
    when '#', 'num', 'number'
      begin
        puts
        @pkmn = dex.select { |poke| poke.num == seek.to_i }
        @pkmn = @pkmn[0]
        puts make_output(@pkmn.num, @pkmn.name, @pkmn.evo,
           @pkmn.prime_type, @pkmn.second_type)
        puts
      rescue
        puts "That number appears to be out of the range of this pokedex."
        puts
      end
    end
  end

  def run_lookup
    FileUtils.cd('..')
    @dex = Dex.pokedex
    @lookup_by = name_or_num
    @seek_which = get_pkmn
    look_in_dex(@dex, @lookup_by, @seek_which)
  end

end

Lookup.new.run_lookup
