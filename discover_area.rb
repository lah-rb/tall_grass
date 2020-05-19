require './explore_area.rb'

class DiscoverArea
  def initialize
    @attributes ||= []
  end

  def get_info(prompt)
    print prompt
    STDIN.gets.chomp.downcase.split(" ").join("_")
  end

  def prompt_store
    ["Do you see any specific pokemon?
      Input by pokedex number: 1-2-3
      If there are no specific pokemon hit return. ", #0
     "How many species do you see?
      Input example: 14
      If you see no speccific number hit return. ", #1
     "What evolution stages are present?
      Input example: 2-3
      If you don't know what evolution stages are here hit return. ", #2
     "What types are present?
      Input example: water-fire-grass
      If you don't see any specific types hit return. ", #3
     "Do legendary exist here?
      Input options:
      only or o - only legendary exist here
      yes or y - some legendary exist here
      no or n - no legendary exist here
      return - some legendary may or may not exist here  ", #4
      "What do you want to call this new area? ", #5
      "What types are not present?
       Input example: water-fire-grass
       If any type maybe here hit return. "] #6
  end

  def prompt_mint(num)
    @prompt = prompt_store[num].split("      ").join
  end

  def evo_proc(evo_arr)
    case evo_arr
    when [1]
      return 'Proc.new { |dex| dex[2].to_i == 1 }'
    when [2]
      return 'Proc.new { |dex| dex[2].to_i == 2 }'
    when [3]
      return 'Proc.new { |dex| dex[2].to_i == 3 }'
    when [1, 2], [2, 1]
      return 'Proc.new { |dex| dex[2].to_i < 3 }'
    when [2, 3], [3, 2]
      return 'Proc.new { |dex| dex[2].to_i > 1 }'
    when [1,3], [3, 1]
      return 'Proc.new { |dex| dex[2].to_i == 1 || dex[2].to_i == 3 }'
    else
      return 'false'
    end
  end

  def enter_area
    puts
    @name = get_info(self.prompt_mint(5)).chomp.downcase.split(" ").join("_")
    @attributes << @name
    puts
    @specific = get_info(self.prompt_mint(0))
    @specific = @specific.split('-').map(&:to_i)
    @attributes << @specific
    puts
    @richness = get_info(self.prompt_mint(1)).to_i
    @attributes << @richness
    puts
    @evo = get_info(self.prompt_mint(2))
    @evo = @evo.split('-').map(&:to_i)
    @evo = evo_proc(@evo)
    @attributes << @evo
    puts
    @yes_types = get_info(self.prompt_mint(3)).split('-')
    @yes_types = false if @yes_types == []
    puts
    @no_types = get_info(self.prompt_mint(6)).split('-')
    @types = @yes_types + ['|'] + @no_types
    @attributes << @types
    puts
    @legend = get_info(self.prompt_mint(4)).downcase
    @attributes << @legend
    puts
  end

  def area_attributes
    return @attributes
  end
end

territory = DiscoverArea.new
territory.enter_area
attributes = territory.area_attributes
p attributes

File.open("./dex_seeds/" + attributes[0], "w") do |seed|
  seed.print attributes
end

area = ExploreArea.new(attributes)
