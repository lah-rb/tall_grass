require_relative '../prompt.rb'
require_relative '../backend/tall_grass.rb'
require_relative '../managers_assistant.rb'
require_relative '../backend/natures.rb'

class Encounter
  include ManagersAssistant
  include Prompt

  TallGrass = TallGrass.new
  Natures = Natures.new

  def provide_type
    get_info(
      prompt_mint(:currentlocalmenu, file_name_to_title(@local)),
      "hit return if it doesn't matter"
    )
  end

  def new_location
    TallGrass.refresh_local
    @local = TallGrass.local_file(
      area_from_list(TallGrass.local_arr, "Where are you?"))
    @proto_dex = TallGrass.set_location(@local)
    if @proto_dex.empty?
      show "We havn't found that place yet! Go find it!"
      new_location
    end
    return @proto_dex
  end

  def type_dex
    @proto_type_dex = TallGrass.make_type_dex(provide_type, @current_location)
    if @proto_type_dex.empty?
      show 'No Pokemon was found in the area with that type.'
      type_dex
    end
    return @proto_type_dex
  end

  def random_output(dex)
    @seed = random_seed(dex)
    show(
      prompt_mint(:encounter, dex[@seed].name, dex[@seed].num, Natures.give_random)
    )
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
