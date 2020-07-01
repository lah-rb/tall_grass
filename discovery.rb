require_relative 'prompt.rb'
require_relative './backend/discover_area.rb'

class Discovery
  include Prompt
  public

  Observations = Struct.new(:name, :specific, :abundance, :evo, :yes, :no, :baby, :fossil, :beast, :legend, :myth, :priority)

  def observe_area
    @name = get_info("What do you want to call this new area? ")

    @specific = get_info(prompt_mint(0))

    @richness = get_info(prompt_mint(1))

    @evo = get_info(prompt_mint(2))

    @yes_types = get_info(prompt_mint(3))

    @no_types = get_info(prompt_mint(4))

    @baby = get_info(prompt_mint(7, 'baby pokemon'))

    @fossil = get_info(prompt_mint(7, 'fossil pokemon'))

    @beast = get_info(prompt_mint(7, 'ultra beasts'))

    @legend = get_info(prompt_mint(7, 'legendary pokemon'))

    @myth = get_info(prompt_mint(7, 'mythical pokemon'))

    @priority = get_info(prompt_mint(8))

    DiscoverArea.new(
      Observations.new(@name, @specific, @richness, @evo, @yes_types, @no_types, @baby, @fossil, @beast, @legend, @myth, @priority)
    )
  end
end

Discovery.new.observe_area
