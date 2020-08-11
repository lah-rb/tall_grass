require_relative '../dir_manager.rb'
require_relative '../managers_assistant.rb'
require_relative '../prompt.rb'
require_relative '../backend/dex.rb'

class DexCase
  include ManagersAssistant
  include Prompt
  include Dex

  attr_reader :locals

  def initialize
    @director = DirManager.new
    @store = './dex_store/'
    @locals = known_areas(@store, Set['events_dex', 'pokedex', 'items_dex'])
  end

  def get_local_dex(local)
    local_num = local.to_i
    if not_in_range?(local, locals)
      show "That number is not on the list!"
    elsif local_num.to_s == local
      @local = locals[local_num - 1]
      Dex.compile_dex(@store + @local + '_dex')
    elsif locals.include? local
      Dex.compile_dex(@store + local + '_dex')
    elsif local == 'pokedex'
      pokedex
    else
      show "We havn't found that place yet! Go find it!"
    end
  end

  def view_dex
    @director.request_dir('backend')
    @local = area_from_list(
      locals,
      "Which area would you like to see it's dex?"
    )
    local_dex = get_local_dex(@local)
    unless local_dex.nil?
      local_dex.map! { |pkmn| pkmn.name + " No. " + pkmn.num.to_s }
      show_list(local_dex, "These are the pokemon in #{file_name_to_title @local}:")
    end
  end
end
