require_relative 'craft_dex.rb'

class DiscoverArea
  def initialize(observation_arr)
    @attributes ||= []
    interpret_observations(observation_arr)
    plant_area_seed
    CraftDex.new(area_seed_arr)
  end

  def evo_proc(evo_arr)
    case evo_arr
    when [1]
      return 'Proc.new { |dex| dex.evo == 1 }'
    when [2]
      return 'Proc.new { |dex| dex.evo == 2 }'
    when [3]
      return 'Proc.new { |dex| dex.evo == 3 }'
    when [1, 2], [2, 1]
      return 'Proc.new { |dex| dex.evo < 3 }'
    when [2, 3], [3, 2]
      return 'Proc.new { |dex| dex.evo > 1 }'
    when [1,3], [3, 1]
      return 'Proc.new { |dex| dex.evo == 1 || dex.evo == 3 }'
    else
      return 'false'
    end
  end

  def interpret_observations(observation_arr)
    # observation_arr:
    # [name, specific, richness, evo, yes, no, legend] All strings

    @name = observation_arr[0].chomp.downcase.split(" ").join("_")
    @attributes << @name

    @specific = observation_arr[1].split('-').map(&:to_i)
    @attributes << @specific

    @richness = observation_arr[2].to_i
    @attributes << @richness

    @evo = evo_proc(observation_arr[3].split('-').map(&:to_i))
    @attributes << @evo

    @yes_types = observation_arr[4].split('-')
    @no_types = observation_arr[5].split('-')
    @types = @yes_types + ['|'] + @no_types
    @types = false if @types == ['|']
    @attributes << @types

    @legend = observation_arr[6].downcase
    @attributes << @legend
  end

  def area_seed_arr
    return @attributes
  end

  def plant_area_seed
    File.open("./dex_seeds/" + area_seed_arr[0], "w") do |seed|
      seed.print area_seed_arr
    end
  end
end
