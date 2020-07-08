require 'fileutils'
require_relative "dex_craftsman.rb"
require_relative "evo.rb"

class RediscoveredArea
  Island = Struct.new(:name, :specific, :abundance, :evo, :type, :distinct, :priority)

  def initialize(land_name)
    FileUtils.cd('backend')

    @seed_path = './dex_seeds/' + land_name.chomp.downcase.gsub(' ', '_') + '.rb'
    require_relative @seed_path

    @name, @specific, @abundance, @stages_arr, @types, @distinct, @priority \
    = NativeFruit.new.seed.dup
    @evolutions = Evo.new(@stages_arr)
    
    DexCraftsman.new(
      Island.new(
        @name, @specific, @abundance, @evolutions, @types, @distinct, @priority
      )
    )
    puts
  end
end
