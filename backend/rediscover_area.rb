require 'fileutils'
require_relative "dex_craftsman.rb"
require_relative "evo.rb"

class RediscoveredArea
  Island = Struct.new(:name, :specific, :abundance, :evo, :type, :distinct, :priority)

  def initialize(land_name)
    FileUtils.cd('backend')
    @seed_path = './dex_seeds/' + land_name.chomp.downcase.gsub(' ', '_') + '.rb'
    require_relative @seed_path
    @native_fruit = NativeFruit.new.seed.dup
    @native_fruit[3] = Evo.new(@native_fruit[3])
    DexCraftsman.new(
      Island.new(
        @native_fruit[0], @native_fruit[1], @native_fruit[2], @native_fruit[3],
        @native_fruit[4], @native_fruit[5], @native_fruit[6]
      )
    )
    puts
  end
end
