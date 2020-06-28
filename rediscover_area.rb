require_relative "dex_craftsman.rb"
require_relative "evo.rb"

class RediscoveredArea
  def initialize(land_name)
    @seed_path = './dex_seeds/' + land_name.chomp.downcase.gsub(' ', '_') + '.rb'
    require_relative @seed_path
    @native_fruit = NativeFruit.new.seed.dup
    a_whole_new_world
  end

  public

  def a_whole_new_world
    @native_fruit[3] = Evo.new(@native_fruit[3])
    DexCraftsman.new(@native_fruit)
    puts
  end
end
