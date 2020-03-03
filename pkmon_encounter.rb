require './dex_maker.rb'

class Encounter
  include DexMaker
  @area_dex = []

  print "Where are you? "
  @area = "./" + STDIN.gets.chomp.downcase.split(" ").join("_") + ".txt"

  print "Any specific type? (Hit return for no type) "
  @type = STDIN.gets.chomp.capitalize

  File.open("#{@area}", 'r') do |f|
    while record = f.gets
      @species = record.chomp
      @area_dex << @species
    end
  end

  if @type.chomp.empty?
    puts @area_dex[rand(0...@area_dex.size)]
  else
    @type_dex = DexMaker::type_select(@area_dex, [@type])
    puts @type_dex[rand(0...@type_dex.size)]
  end
end
