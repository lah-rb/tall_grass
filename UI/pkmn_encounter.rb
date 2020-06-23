require 'fileutils'
require_relative '../dex_maker.rb'
require_relative '../dex.rb'

class Encounter
  include DexMaker
  include Dex
  FileUtils.cd('..')

  def initialize
    encountering
  end

  def get_location(prompt="Where are you? ")
    puts
    print prompt
    @local = $stdin.gets.chomp.downcase.gsub(" ", "_")
    if @local == 'pokedex'
      return './dex_store/' + @local
    else
      return './dex_store/' + @local + "_dex"
    end
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

  def random_output(array)
    @seed = rand(0...array.size)
    puts array.dig(@seed,1) + " No. " + array.dig(@seed,0)
    puts
  end

  def set_location
    @area = get_location

    begin
      @area_dex = Dex.compile_dex(@area)
    rescue
      puts "A file coordinating to that name was not found."
      puts
      set_location
    end
  end

  def make_type_dex
    @type = provide_type

    if @type.chomp.empty?
      random_output(@area_dex)
    else
      @type_dex = DexMaker::type_select(@area_dex, [@type])
      # This error check assumes that the area does not contain the type provided
      if @type_dex.empty?
        puts 'No Pokemon was found in that area with that type'
        puts
        make_type_dex
      else
        random_output(@type_dex)
      end
    end
  end

  def encountering
    set_location if caller.size == 3 || continue?("Would you like a new location? (y/return) ")
    make_type_dex
    encountering if continue?("Would you like to have another encounter? (y/return) ")
  end
end

Encounter.new
