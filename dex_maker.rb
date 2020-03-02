require './dex.rb'

module DexMaker
  include Dex
  @babydex = []
  @incubator = []
  Dex::pokedex.select do |num, entry|
    if entry[1] == "1" && entry[0].split("").pop.match?(/["^"|!|#]/) == false
      @babydex << entry[0]
    end
  end

  def self.load_incubator
    @seed = rand(0..@babydex.size - 1)
    @specimen = @babydex[@seed]
    if @incubator.none?(@specimen)
      @incubator << @specimen
    else
      self.load_incubator
    end
  end

  (0..19).each do |i|
    self.load_incubator
  end

  File.open('./incubator_facility.txt', 'w') do |new_dex|
    @incubator.each {|entry| new_dex.puts(entry)}
  end
end
