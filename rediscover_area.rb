require_relative "dex_craftsman.rb"

class RediscoveredArea
  def initialize(land_name)
    @seed = land_name.chomp.downcase.gsub(" ", "_")
    a_whole_new_world
  end

  def a_whole_new_world
    File.open("./dex_seeds/" + @seed, "r") { |file| @attributes = file.gets }
    DexCraftsman.new(eval(@attributes))
    puts "#{@seed.gsub('_', ' ')} is like a whole new world!"
  end
end
