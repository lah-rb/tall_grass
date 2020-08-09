require_relative '../prompt.rb'
require_relative '../backend/dex_shelf.rb'

class Librarian
  include Prompt

  def look_up
    @pkmn = DexShelf.new.look_in_dex(get_pkmn)
    display(
      make_output(@pkmn.num, @pkmn.name, @pkmn.evo,
      @pkmn.prime_type, @pkmn.second_type, :name)
    ) if @pkmn
  end

  private

  def get_pkmn
    get_info('What are you searching for?', 'Enter name or number').capitalize
  end

  def make_output(num, name, evo, type_1, type_2, method)
    case method
    when :name
      @first = name
      @second = "pokedex entry No." + num.to_s
    when :num
      @first = "Pokedex entry No." + num.to_s
      @second = name
    end
    return prompt_mint(:pkmninfo, @first, @second, evo.to_s, type_1, type_2)
  end
end
