require_relative 'dex_craftsman.rb'
require_relative 'evo.rb'
require_relative 'gardener.rb'

class DiscoverArea
  def initialize(observation_arr)
    @attributes ||= []
    interpret_observations(observation_arr)
    note_attributes
    DexCraftsman.new(@attributes)
  end

  private

  def interpret_observations(observation_arr)
    # observation_arr:
    # [name, specific, richness, evo, yes, no, legend] All strings

    @name = observation_arr[0].chomp.downcase.gsub(" ", "_")
    @attributes << @name

    @specific = observation_arr[1].split('-').map(&:to_i)
    @attributes << @specific

    @richness = observation_arr[2].to_i
    @attributes << @richness

    @ints_arr = observation_arr[3].split('-').map(&:to_i)
    @evo = Evo.new(@ints_arr)
    @attributes << @evo

    @yes_types = observation_arr[4].split('-')
    @no_types = observation_arr[5].split('-')
    @types = @yes_types + ['|'] + @no_types
    @types = false if @types == ['|']
    @attributes << @types

    @legend = observation_arr[6].downcase
    @attributes << @legend
  end

  def note_attributes
    @seed = @attributes.dup
    @seed[3] = @ints_arr
    Gardener.new.plant_area_seed(@seed)
  end
end
