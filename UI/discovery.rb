require 'fileutils'
require_relative 'prompt.rb'
require_relative '../discover_area.rb'

# [name, specific, richness, evo, yes, no, legend]
class Discovery
  include Prompt

  def initialize
    FileUtils.cd('..')
  end

  def observe_area
    @name = get_info(prompt_mint(5))

    @specific = get_info(prompt_mint(0))

    @richness = get_info(prompt_mint(1))

    @evo = get_info(prompt_mint(2))

    @yes_types = get_info(prompt_mint(3))

    @no_types = get_info(prompt_mint(6))

    @legend = get_info(prompt_mint(4))
    puts
    DiscoverArea.new([@name, @specific, @richness, @evo, @yes_types, @no_types, @legend])
  end
end

new_island = Discovery.new
new_island.observe_area
