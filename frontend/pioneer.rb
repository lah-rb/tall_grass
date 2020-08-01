require_relative '../prompt.rb'
require_relative '../backend/discovery.rb'

class Pioneer
  include Prompt

  Observations = Struct.new(:name, :specific, :abundance, :evo, :yes, :no, :baby, :fossil, :beast, :legend, :myth, :priority)

  def initialize

    @name = get_info("What do you want to call this new area? ")

    @specific = get_info(prompt_mint(:specificmenu))

    @richness = get_info(prompt_mint(:populationmenu))

    @evo = get_info(prompt_mint(:evomenu))

    @yes_types = get_info(prompt_mint(:presenttypes))

    @no_types = get_info(prompt_mint(:absenttypes))

    @baby = get_info(prompt_mint(:tribemenu, 'baby pokemon'))

    @fossil = get_info(prompt_mint(:tribemenu, 'fossil pokemon'))

    @beast = get_info(prompt_mint(:tribemenu, 'ultra beasts'))

    @legend = get_info(prompt_mint(:tribemenu, 'legendary pokemon'))

    @myth = get_info(prompt_mint(:tribemenu, 'mythical pokemon'))

    @priority = get_info(prompt_mint(:conflictmenu))

    Discovery.new(
      Observations.new(@name, @specific, @richness, @evo, @yes_types, @no_types, @baby, @fossil, @beast, @legend, @myth, @priority)
    )
  end
end
