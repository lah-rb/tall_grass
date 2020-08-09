require_relative '../dir_manager.rb'
require_relative '../prompt.rb'
require_relative '../backend/expedition.rb'


class Explorer
  include Prompt

  def make_landing
    @store = './dex_seeds/'
    @director = DirManager.new
    @director.request_dir('backend')
    Expedition.new.embark_to(get_location)
  end

  def local_arr
    Dir[@store + '*'].sort.map do |dir|
      dir.split('/')[-1][/^.*[.]/]
    end
  end

  def get_location
    @all_locals = local_arr - [nil, 'events', 'pokedex', 'items']
    display_list(
      @all_locals.map { |local| file_name_to_title(local.slice(0...-1)) },
      'Areas currently known:')
    @local = get_info("Where are you looking to explore again?", "Enter 'all' to refresh all dex").downcase.gsub(" ", "_")

    case @local.to_i
    when 0
      @local
    else
      @all_locals.map { |local| local.slice(0...-1) }[@local.to_i - 1]
    end
  end
end
