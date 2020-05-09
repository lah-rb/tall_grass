require './dex_maker.rb'
require './dex.rb'

class Encounter
  include DexMaker
  include Dex

  def self.get_location(prompt="Where are you? ")
    print prompt
    $store + STDIN.gets.chomp.downcase.split(" ").join("_") + "_dex"
  end

  def self.provide_type
    print "Any specific type? (Hit return for no type) "
    return STDIN.gets.chomp
  end

  def self.continue?(statement="Continue? (y/return) ")
    print statement
    true if STDIN.gets.chomp.downcase == 'y'
  end

  def self.random_output(array)
    @seed = rand(0...array.size)
    puts array.dig(@seed,1) + " No. " + array.dig(@seed,0)
  end

  def self.set_location
    @area = self.get_location

    begin
      @area_dex = Dex::compile_dex(@area)
    rescue
      puts "A file coordinating to that name was not found."
      set_location
    end
  end

  def self.make_type_dex
    @type = self.provide_type

    if @type.chomp.empty?
      self.random_output(@area_dex)
    else
      @type_dex = DexMaker::type_select(@area_dex, [@type])
      # This error check assumes that the area does not contain the type provided
      if @type_dex.empty?
        puts 'No Pokemon was found in that area with that type'
        make_type_dex
      else
        self.random_output(@type_dex)
      end
    end
  end

  def self.encountering
    self.set_location if caller.size == 2 || self.continue?("Would you like a new location? (y/return) ")
    self.make_type_dex
    encountering if self.continue?("Would you like to have another encounter? (y/return) ")
  end
  self.encountering
end
