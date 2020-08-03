require_relative '../dir_manager.rb'
require_relative '../prompt.rb'
require_relative 'dex_maker_toolbox.rb'
require_relative 'dex.rb'

class TallGrass
  include Prompt
  include DexMakerToolbox
  include Dex

def store
  './dex_store/'
end

  def initialize()
    @director = DirManager.new
  end

  def local_arr
    @director.request_dir('backend')
    special_dex = Set['events_dex', 'pokedex', 'items_dex']
    Dir[store + '*'].sort.reduce([]) do |areas, dir|
      dex = dir.split('/')[-1]
      areas << dex unless special_dex.include?(dex)
      areas
    end
  end

  def set_location(area)
    @director.request_dir('backend')
    if local_arr.include? area
      Dex.compile_dex(store + area)
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
