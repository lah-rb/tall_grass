require './area_maker.rb'

class Encounter
  include AreaMaker

  def self.location
    print "Where are you? "
    return AreaMaker::store + STDIN.gets.chomp.downcase.split(" ").join("_") + ".txt"
  end

  def self.provide_type
    print "Any specific type? (Hit return for no type) "
    return STDIN.gets.chomp
  end

  def self.continue?
    print "Would you like to have another encounter? (y/n) "
    true if STDIN.gets.chomp.downcase == 'y'
  end

  def self.random_output(array)
    @seed = rand(0...array.size)
    puts array.dig(@seed,1) + " No. " + array.dig(@seed,0)
  end

  def self.make_area_dex
    @type = self.provide_type

    if @type.chomp.empty?
      self.random_output(@area_dex)
    else
      @type_dex = DexMaker::type_select(@area_dex, [@type])
      # This error check assumes that the area does not contain the type provided
      if @type_dex.empty?
        puts 'No Pokemon was found in that area with that type'
        self.make_area_dex
      else
        self.random_output(@type_dex)
      end
    end
  end

  def self.encountering
    @area = self.location
    @area_dex = Dex::compile_dex(@area)
    self.make_area_dex
    self.encountering if self.continue?
  end

  self.encountering
end
