require_relative '../dir_manager.rb'
require_relative '../prompt.rb'
require_relative '../backend/tall_grass.rb'

class Encounter
  include Prompt

  def initialize()
    DirManager.new('tall_grass')
    @tall_grass = TallGrass.new
    @store = './dex_store/'
    encountering(true)
  end

  def get_location(local_statement = "Where are you? ", file_sort = /^.*[_]/, is_dex = true)
    @all_locals = Dir[@store + '*'].sort.map do |dir|
      dir.split('/')[-1][file_sort]
    end
    @all_locals -= [nil, 'events_', 'pokedex']
    display_list(
      @all_locals.map { |local| file_name_to_title(local.slice(0...-1)) },
      'Areas currently known:')
    @local = get_info(local_statement).downcase.gsub(" ", "_")
    case @local.to_i
    when 0
      if is_dex
        @local == 'pokedex' ? @store + @local : @store + @local + '_dex'
      else
        @local
      end
    else
      @local = @all_locals.map { |local| local.slice(0...-1) }[@local.to_i - 1]
      if is_dex
        @store + @local + '_dex'
      else
        @local
      end
    end
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
