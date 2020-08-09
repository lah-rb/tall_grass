require 'set'
require_relative '../prompt.rb'
require_relative '../backend/tall_grass.rb'
require_relative '../managers_assistant.rb'

class Encounter
  include ManagersAssistant
  include Prompt

  TallGrass = TallGrass.new

  def provide_type
    get_info(
      prompt_mint(:currentlocalmenu, file_name_to_title(@local)),
      "hit return if it doesn't matter"
    )
  end

  def area_from_list
    display_list(
      TallGrass.local_arr.map { |area| file_name_to_title(area).slice(0..-5) },
      'Areas currently known:'
    )
    get_info("Where are you?").downcase.gsub(" ", "_")
  end

  def local_file
    @requested_area = area_from_list
    @requested_num = @requested_area.to_i

    if not_in_range?(@requested_area, TallGrass.local_arr)
      display "That number is not on the list!"
      local_file
    elsif  @requested_num.to_s == @requested_area
      @local = TallGrass.local_arr[@requested_num - 1].slice(0..-5)
    else
      @local = @requested_area
    end

    unless @local == 'pokedex'
      @local + '_dex'
    else
      @local
    end
  end

  def new_location
    @proto_dex = TallGrass.set_location(local_file)
    if @proto_dex.empty?
      display "We havn't found that place yet! Go find it!"
      new_location
    end
    return @proto_dex
  end

  def type_dex
    @proto_type_dex = TallGrass.make_type_dex(provide_type, @current_location)
    if @proto_type_dex.empty?
      display 'No Pokemon was found in the area with that type.'
      type_dex
    end
    return @proto_type_dex
  end

  def random_output(dex)
    @seed = random_seed(dex)
    display(dex[@seed].name + " No. " + dex[@seed].num.to_s)
  end

  def look_for_trouble(is_new = true)
    if is_new
      @current_location = new_location
    end

    random_output(type_dex)

    if continue?("Would you like to have another encounter?")
      look_for_trouble(false)
    end
  end
end
