require 'fileutils'
require_relative 'dex.rb'

class DexShelf
  public
  include Dex

  def initialize
    FileUtils.cd('backend')
    @dex = Dex.pokedex
  end

  def look_in_dex(search_means, seek)
    case search_means
    when 'name', 'nam'
      begin
        @pkmn = @dex.find do |poke|
          if poke.name.match?(/["^"|!|#|*|~]/)
           poke.name.chop == seek
          else
           poke.name == seek
          end
        end
        puts
        puts make_output(@pkmn.num, @pkmn.name, @pkmn.evo,
           @pkmn.prime_type, @pkmn.second_type, :name)
      rescue
        puts "That name does not exist. Please check for spelling."
      end
    when '#', 'num', 'number'
      begin
        puts
        @pkmn = @dex.find { |poke| poke.num == seek.to_i }
        puts make_output(@pkmn.num, @pkmn.name, @pkmn.evo,
           @pkmn.prime_type, @pkmn.second_type, :number)
      rescue
        puts "That number appears to be out of the range of this pokedex."
      end
    end
  end

  private

  def make_output(num, name, evo, type_1, type_2, method)
    case method
    when :name
      @first = name
      @second = "pokedex entry No." + num.to_s
    when :number
      @first = "Pokedex entry No." + num.to_s
      @second = name
    end
    @info_string =
    "#{@first} is \
    #{@second}. This pokemon is at evolution stage \
    #{evo.to_s} and is typed as \
    #{type_1}#{"-" + type_2 unless type_2 == '%'}."
    return @info_string.split("  ").join
  end
end
