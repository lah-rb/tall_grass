require_relative '../dir_manager.rb'
require_relative '../prompt.rb'
require_relative 'dex.rb'

class DexShelf
  include Prompt
  include Dex

  public

  def initialize
    DirManager.new('backend')
    @dex = Dex.pokedex
  end

  def look_in_dex(search_means, seek)
    case search_means
    when :name
      @pkmn = @dex.find do |poke|
        if poke.name.match?(/["^"|!|#|*|~]/)
         poke.name.chop == seek
        else
         poke.name == seek
        end
      end
      begin
        display(
          make_output(@pkmn.num, @pkmn.name, @pkmn.evo,
          @pkmn.prime_type, @pkmn.second_type, :name))
      rescue
        display "That name does not exist. Please check for spelling."
      end
    when :num
      @pkmn = @dex.find { |poke| poke.num == seek.to_i }
      begin
        display(
          make_output(@pkmn.num, @pkmn.name, @pkmn.evo,
          @pkmn.prime_type, @pkmn.second_type, :num))
      rescue
        display "That number appears to be out of the range of this pokedex."
      end
    end
  end

  private

  def make_output(num, name, evo, type_1, type_2, method)
    case method
    when :name
      @first = name
      @second = "pokedex entry No." + num.to_s
    when :num
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
