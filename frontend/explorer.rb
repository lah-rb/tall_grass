require_relative '../dir_manager.rb'
require_relative '../prompt.rb'
require_relative '../backend/expedition.rb'
require_relative '../managers_assistant.rb'


class Explorer
  include Prompt
  include ManagersAssistant

  def make_landing
    @store = './dex_seeds/'
    @director = DirManager.new
    @director.request_dir('backend')
    Expedition.new.embark_to(get_location)
  end

  def get_location
    @all_locals = known_areas(@store)
    @local = area_from_list(
      @all_locals,
      "Where are you looking to explore again?",
      "Enter 'all' to refresh all dex"
    )

    case @local.to_i
    when 0
      @local
    else
      @all_locals.map { |local| local.slice(0...-1) }[@local.to_i - 1]
    end
  end
end
