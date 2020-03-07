require './dex_maker.rb'
require './area_maker.rb'

class Encounter
  include DexMaker
  include AreaMaker

  @area_dex = []

  def self.location
    print "Where are you? "
    return AreaMaker::store + STDIN.gets.chomp.downcase.split(" ").join("_") + ".txt"
  end

  def self.provide_type
    print "Any specific type? (Hit return for no type) "
    return STDIN.gets.chomp
  end

  @area = self.location
  File.open("#{@area}", 'r') do |f|
    while record = f.gets
      @species = record.chomp.split("-")
      @area_dex << @species
    end
  end

  def self.make_area_dex
    @type = self.provide_type

    if @type.chomp.empty?
      @seed = rand(0...@area_dex.size)
      puts @area_dex.dig(@seed,1) + " No. " + @area_dex.dig(@seed,0)
    else
      @type_dex = DexMaker::type_select(@area_dex, [@type])
      # This error check assumes that the area does not contain the type provided
      if @type_dex.empty?
        puts 'No Pokemon was found in that area with that type'
        self.make_area_dex
      else
        @seed = rand(0...@type_dex.size)
        puts @type_dex.dig(@seed,1) + " No. " + @type_dex.dig(@seed,0)
      end
    end
  end

  self.make_area_dex

end
