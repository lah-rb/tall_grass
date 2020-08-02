require_relative '../dir_manager.rb'
require_relative 'dex_craftsman.rb'
require_relative 'evo.rb'
require_relative 'distinctions.rb'

class Discovery
  public

  AcceptedTypes = [
    'Normal', 'Fire', 'Water', 'Grass', 'Electric', 'Ice', 'Fighting', 'Poison',
    'Ground', 'Flying', 'Psychic', 'Bug', 'Rock', 'Ghost', 'Dragon', 'Dark',
    'Steel', 'Fairy'
  ]
  Environment = Struct.new(:name, :specific, :abundance, :evo, :type, :distinct, :priority)
  Fauna = Struct.new(:baby, :fossil, :beast, :legend, :myth)

  def initialize(observations)
    @director = DirManager.new
    @director.request_dir('backend')
    interpret(observations)
    note_attributes
    DexCraftsman.new(
      Environment.new(@name, @specific, @richness, @evo, @types, @distinct, @priority)
    )
  end

  private

  def interpret(observations)
    @name = observations.name.chomp.downcase.gsub(" ", "_").gsub('/', '_')

    @specific = observations.specific.split('-').map(&:to_i)

    @richness = observations.abundance.to_i

    @stages_arr = observations.evo.split('-').map(&:to_i)
    begin
      @evo = Evo.new(@stages_arr)
    rescue BadEvoError
      @stages_arr = []
      @evo = Evo.new(@stages_arr)
    end

    @yes_types = observations.yes.split('-').map(&:capitalize).keep_if do |type|
      AcceptedTypes.include?(type)
    end
    @no_types = observations.no.split('-').map(&:capitalize).keep_if do |type|
      AcceptedTypes.include?(type)
    end
    @types = @yes_types + ['|'] + @no_types
    @types = false if @types == ['|']

    @baby = observations.baby.chr.downcase unless observations.baby.empty?

    @fossil = observations.fossil.chr.downcase unless observations.fossil.empty?

    @beast = observations.beast.chr.downcase unless observations.beast.empty?

    @legend = observations.legend.chr.downcase unless observations.legend.empty?

    @myth = observations.myth.chr.downcase unless observations.myth.empty?

    case observations.priority.chr.downcase
    when 'e'
      @priority = :evo
    else
      @priority = :dis
    end

    @distinct = Distinctions.new(
      Fauna.new(@baby, @fossil, @beast, @legend, @myth)).convert_to_regex
  end

  def note_attributes
    File.open("./dex_seeds/" + @name + '.rb', "w") do |line|
      line.puts "class NativeFruit"
      line.puts "  def seed"
      line.print "    "
      line.print [@name, @specific, @richness, @stages_arr, @types, @distinct, @priority]
      line.print "\n"
      line.puts "  end"
      line.puts "end"
    end
  end
end
