require 'fileutils'
require_relative 'dex_maker_toolbox.rb'
require_relative 'dex.rb'
require_relative '../prompt.rb'

class TallGrass
  include Prompt
  include DexMakerToolbox
  include Dex

  def initialize()
    FileUtils.cd('backend')
  end

  def random_output(dex)
    @seed = rand(0...dex.size)
    display(dex[@seed].name + " No. " + dex[@seed].num.to_s)
    return true
  end

  def set_location(area)
    @area_dex = Dex.compile_dex(area)
  end

  def make_type_dex(type)
    if type.chomp.empty?
      random_output(@area_dex)
    else
      @type_dex = DexMakerToolbox.type_select(@area_dex, [type])
      # This error check assumes that the area does not contain the type provided
      if @type_dex.empty?
        return false
      else
        random_output(@type_dex)
      end
    end
  end
end
