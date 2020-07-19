require 'open-uri'
require_relative '../dir_manager.rb'
require_relative '../prompt.rb'
require_relative 'dex_maker_toolbox.rb'
require_relative 'dex.rb'
require_relative 'distributer.rb'

class TallGrass < Distributer
  include Prompt
  include DexMakerToolbox
  include Dex

  def initialize()
    @director = DirManager.new
    @director.request_dir('backend')
  end

  def set_location(area)
    @area_dex = Dex.compile_dex(area)
  end

  def make_type_dex(type)
    if type.chomp.empty?
      random_output(@area_dex)
    else
      @type_dex = DexMakerToolbox.type_select(@area_dex, [type])
      # This error check assumes that the area doesn't contain the type provided
      @type_dex.empty? ? false : random_output(@type_dex)
    end
  end

  def random_output(dex)
    @seed = random_seed(dex)
    display(dex[@seed].name + " No. " + dex[@seed].num.to_s)
    return true
  end
end
