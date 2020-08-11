require_relative '../dir_manager.rb'
require_relative '../prompt.rb'
require_relative 'dex_maker_toolbox.rb'
require_relative 'dex.rb'
require_relative '../managers_assistant.rb'

class TallGrass
  include Prompt
  include ManagersAssistant
  include DexMakerToolbox
  include Dex

  attr_reader :local_arr

  def initialize
    @director = DirManager.new
    @store = './dex_store/'
    @local_arr = known_areas(@store, Set['events_dex', 'pokedex', 'items_dex'])
  end

  def local_file(requested_area)
    @director.request_dir('backend')
    @requested_area = requested_area
    @requested_num = @requested_area.to_i

    if not_in_range?(@requested_area, local_arr)
      show "That number is not on the list!"
      local_file
    elsif  @requested_num.to_s == @requested_area
      return local_arr[@requested_num - 1]
    else
      return @requested_area
    end
  end

  def set_location(area)
    @director.request_dir('backend')
    if local_arr.include?(area)
      Dex.compile_dex(@store + area + '_dex')
    elsif area == 'pokedex'
      pokedex
    else
      []
    end
  end

  def make_type_dex(type, dex)
    @director.request_dir('backend')
    if type.chomp.empty?
      dex
    else
      DexMakerToolbox.type_select(dex, [type])
    end
  end
end
