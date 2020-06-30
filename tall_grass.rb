require_relative 'dex_maker_toolbox.rb'
require_relative 'dex.rb'

class TallGrass
  include DexMakerToolbox
  include Dex

  def random_output(dex)
    @seed = rand(0...dex.size)
    puts dex[@seed].name + " No. " + dex[@seed].num.to_s
    puts
  end

  def set_location(area)
    begin
      @area_dex = Dex.compile_dex(area)
    rescue
      puts "A file coordinating to that name was not found."
      puts
      set_location
    end
  end

  def make_type_dex(type)
    if type.chomp.empty?
      random_output(@area_dex)
    else
      @type_dex = DexMakerToolbox.type_select(@area_dex, [type])
      # This error check assumes that the area does not contain the type provide
      if @type_dex.empty?
        puts 'No Pokemon was found in that area with that type'
        puts
        make_type_dex
      else
        random_output(@type_dex)
      end
    end
  end
end
