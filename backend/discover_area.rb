require 'fileutils'
require_relative 'dex_craftsman.rb'
require_relative 'evo.rb'
require_relative 'distinctions.rb'

class DiscoverArea
  public
  Island = Struct.new(:name, :specific, :abundance, :evo, :type, :distinct, :priority)
  Include = Struct.new(:baby, :fossil, :beast, :legend, :myth)

  def initialize(observations)
    FileUtils.cd('backend')
    interpret(observations)
    note_attributes
    DexCraftsman.new(
      Island.new(@name, @specific, @richness, @evo, @types, @distinct, @priority)
    )
  end

  private

  def interpret(observations)
    @name = observations.name.chomp.downcase.gsub(" ", "_")

    @specific = observations.specific.split('-').map(&:to_i)

    @richness = observations.abundance.to_i

    @ints_arr = observations.evo.split('-').map(&:to_i)
    @evo = Evo.new(@ints_arr)

    @yes_types = observations.yes.split('-')
    @no_types = observations.no.split('-')
    @types = @yes_types + ['|'] + @no_types
    @types = false if @types == ['|']

    @baby = observations.baby.downcase[0] unless observations.baby.empty?

    @fossil = observations.fossil.downcase[0] unless observations.fossil.empty?

    @beast = observations.beast.downcase[0] unless observations.beast.empty?

    @legend = observations.legend.downcase[0] unless observations.legend.empty?

    @myth = observations.myth.downcase[0] unless observations.myth.empty?

    unless observations.priority.empty?
      @priority = observations.priority.downcase[0]
    else
      @priority = 'd'
    end

    @distinct = Distinctions.new(Include.new(@baby, @fossil, @beast, @legend, @myth)).convert_to_regex
  end

  def note_attributes
    File.open("./dex_seeds/" + @name + '.rb', "w") do |line|
      line.puts "class NativeFruit"
      line.puts "  def seed"
      line.print "    "
      line.print [@name, @specific, @richness, @ints_arr, @types, @distinct, @priority]
      line.print "\n"
      line.puts "  end"
      line.puts "end"
    end
  end
end
