require 'fileutils'
require_relative 'prompt.rb'
require_relative '../tall_grass.rb'

class Encounter
  include Prompt

  def initialize()
    FileUtils.cd('..')
    @tall_grass = TallGrass.new
  end

  def get_location
    @local = get_info("Where are you? ").downcase.gsub(" ", "_")
    @local == 'pokedex' ? './dex_store/' + @local : './dex_store/' + @local + "_dex"
  end

  def provide_type
    get_info(prompt_mint(8))
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

  def encountering
    begin
      @tall_grass.set_location(get_location) if caller.size == 1 || continue?("Would you like a new location? (y/return) ")
    rescue
      display('A file coordinating to that name was not found.')
      @tall_grass.set_location(get_location)
    end

    unless @tall_grass.make_type_dex(provide_type)
      display('No Pokemon was found in that area with that type.')
      @tall_grass.make_type_dex(provide_type)
    end
    
    encountering if continue?("Would you like to have another encounter? (y/return) ")
  end
end

Encounter.new.encountering
