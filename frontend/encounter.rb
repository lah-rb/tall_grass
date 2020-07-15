require_relative '../prompt.rb'
require_relative '../backend/tall_grass.rb'

class Encounter
  include Prompt

  def initialize()
    @tall_grass = TallGrass.new
    @store = './dex_store/'
    encountering(true)
  end

  def provide_type
    get_info(prompt_mint(6, file_name_to_title(@local)))
  end

  def continue?(statement="Continue? (y/return) ")
    @continue = get_info(statement).downcase
    case @continue
    when 'y', 'yes'
      return true
    when ''
      return false
    else
      continue?
    end
  end

  def encountering(new_encounter)
    begin
      @tall_grass.set_location(get_location) if new_encounter || continue?("Would you like a new location? (y/return) ")
    rescue
      display 'A file coordinating to that name was not found.'
      @tall_grass.set_location(get_location)
    end

    unless @tall_grass.make_type_dex(provide_type)
      display 'No Pokemon was found in that area with that type.'
      @tall_grass.make_type_dex(provide_type)
    end

    encountering(false) if continue?("Would you like to have another encounter? (y/return) ")
  end
end
