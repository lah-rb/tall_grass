require_relative '../prompt.rb'
require_relative '../backend/dex_shelf.rb'

class Librarian
  include Prompt
  public

  def look_up
    DexShelf.new.look_in_dex(name_or_num, get_pkmn)
  end

  private

  def name_or_num
    case get_info('Lookup by species name or number?', 'name/#').downcase
    when 's', 'species', 'name'
      return :name
    when '#', 'num', 'number'
      return :num
    end
  end

  def get_pkmn
    get_info('What are you searching for?').capitalize
  end
end
