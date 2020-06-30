require_relative 'dex_craftsman.rb'
require_relative 'evo.rb'

class DiscoverArea
  public
  Island = Struct.new(:name, :specific, :abundance, :evo, :type, :legend)

  def initialize(observations)
    @attributes ||= []
    interpret(observations)
    note_attributes
    DexCraftsman.new(Island.new(@name, @specific, @richness, @evo, @types, @legend))
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

    @legend = observations.legend.downcase
  end

  def note_attributes
    File.open("./dex_seeds/" + @name + '.rb', "w") do |line|
      line.puts "class NativeFruit"
      line.puts "  def seed"
      line.print "    "
      line.print [@name, @specific, @richness, @ints_arr, @types, @legend]
      line.print "\n"
      line.puts "  end"
      line.puts "end"
    end
  end
end
