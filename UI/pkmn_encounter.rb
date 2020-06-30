require 'fileutils'
require_relative '../tall_grass.rb'

class Encounter
  def initialize()
    FileUtils.cd('..')
    @tall_grass = TallGrass.new
  end

  def get_location
    puts
    print "Where are you? "
    @local = $stdin.gets.chomp.downcase.gsub(" ", "_")
    @local == 'pokedex' ? './dex_store/' + @local : './dex_store/' + @local + "_dex"
  end

  def provide_type
    puts
    puts "Current location: #{@local.gsub('_', ' ')}"
    print "Any specific type? (Hit return for no type) "
    return $stdin.gets.chomp
  end

  def continue?(statement="Continue? (y/return) ")
    puts
    print statement
    @continue = $stdin.gets.chomp.downcase
    case @continue
    when 'y', 'yes'
      return true
    when ''
      return false
    else
      continue?
    end
  end

  def encountering
    @tall_grass.set_location(get_location) if caller.size == 1 || continue?("Would you like a new location? (y/return) ")
    @tall_grass.make_type_dex(provide_type)
    encountering if continue?("Would you like to have another encounter? (y/return) ")
  end
end

Encounter.new.encountering
