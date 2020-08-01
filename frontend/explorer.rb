require_relative '../dir_manager.rb'
require_relative '../prompt.rb'
require_relative '../backend/expedition.rb'


class Explorer
  include Prompt

  def initialize
    @store = './dex_seeds/'
    @director = DirManager.new
    @director.request_dir('backend')
    begin
      Expedition.new(
        get_location(
          local_arr, "Where are you looking to explore again? "
        )
      )
    rescue LoadError, NoMethodError
      display "We havn't found that place yet! Go find it!"
    end
  end

  def local_arr
    Dir[@store + '*'].sort.map do |dir|
      dir.split('/')[-1][/^.*[.]/]
    end
  end

  def get_location(local_arr, local_statement = "Where are you? ")
    local_arr -= [nil, 'events', 'pokedex', 'items']
    display_list(
      local_arr.map { |local| file_name_to_title(local.slice(0...-1)) },
      'Areas currently known:')
    @local = get_info(local_statement).downcase.gsub(" ", "_")

    case @local.to_i
    when 0
      @local
    else
      local_arr.map { |local| local.slice(0...-1) }[@local.to_i - 1]
    end
  end
end
