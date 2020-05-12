require './explore_area.rb'

class DiscoverArea
  def get_info(prompt)
    print prompt
    STDIN.gets.chomp.downcase.split(" ").join("_")
  end
  def prompt_store
    ["Do you see any specific pokemon?
      Input by pokedex number: 1-2-3
      If there are no specific pokemon hit return. ",
     "How many species do you see?
      Input example: 14
      If you see no speccific number hit return. ",
     "What evolution stages are present?
      Input example: 2-3
      If you don't know what evolution stages are here hit return. ",
     "What types are present?
      Input example: water-fire-grass
      If you don't see any specific types hit return. ",
     "Do legendary exist here?
      Input options:
      only or o - only legendary exist here
      yes or y - some legendary exist here
      no or n - no legendary exist here
      return - some legendary may or may not exist here  ",
      "What do you want to call this new area? "]
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
    @area_name = get_info(self.prompt_mint(5)).chomp.downcase.split(" ").join("_")
    puts
    @specific = get_info(self.prompt_mint(0))
    @specific = @specific.split('-').map (&:to_i)
    puts
    @richness = get_info(self.prompt_mint(1)).to_i
    puts
    @evo = get_info(self.prompt_mint(2))
    @evo = @evo.split('-').map (&:to_i)
    @evo = evo_proc(@evo)
    puts
    @types = get_info(self.prompt_mint(3)).split('-')
    @types = false if @types == []
    puts
    @legend = get_info(self.prompt_mint(4))
    puts
    case @legend.downcase
    when 'yes', 'y'
      @legend = true
    when 'no', 'n'
      @legend = false
    else
      @legend = nil
    end
  end
end

territory = DiscoverArea.new
territory.enter_area
attributes = territory.instance_variables.select { |sym| sym != :@prompt  }
attributes.map! { |attr| territory.instance_variable_get(attr) }

File.open("./dex_seed/" + attributes[0], "w") do |seed|
  seed.print attributes
end

area = ExploreArea.new(attributes)
area.set_location
area.set_dex

#next step is to create a a store file of the attributes array and a
#refresh_area script to have the same attributes reapplied to the dex
