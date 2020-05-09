require './explore_area.rb'

class DiscoverArea
  def get_info(prompt)
    print prompt
    STDIN.gets.chomp.downcase.split(" ").join("_")
  end
  def prompt_store
    ["Are there any specific pokemon in this area?
      Input example: 1-2-3
      If you do not want any specific pokemon hit return. ",
     "How many species are in this area?
      Input example: 14
      If you do not want to specify a number hit return. ",
     "What evolution stages are present?
      Input example: 2-3
      If you do not want to specify evolution stages hit return. ",
     "What types are present?
      Input example: water-fire-grass
      If you do not want to specify types hit return. ",
     "Do legendary exist here?
      Input example: yes
      If you do not want to specify types hit return. "]
  end

  def prompt_mint(num)
    @prompt = prompt_store[num].split("      ").join
  end

  def evo_proc(evo_arr)
    case evo_arr
    when []
      return false
    when [1, 2, 3]
      return false
    when [1]
      return Proc.new { |dex| dex[2].to_i == 1 }
    when [2]
      return Proc.new { |dex| dex[2].to_i == 2 }
    when [3]
      return Proc.new { |dex| dex[2].to_i == 3 }
    when [1, 2]
      return Proc.new { |dex| dex[2].to_i < 3 }
    when [2, 3]
      return Proc.new { |dex| dex[2].to_i > 1 }
    when [1,3]
      return Proc.new { |dex| dex[2].to_i == 1 || dex[2].to_i == 3 }
    end
  end

  def enter_area
    @area_name = get_info("What do you want to call this new land? ")
    puts
    @specific = get_info(self.prompt_mint(0))
    @specific = @specific.split('-').map { |num| num.to_i }
    puts
    @richness = get_info(self.prompt_mint(1)).to_i
    puts
    @evo = get_info(self.prompt_mint(2))
    @evo = @evo.split('-').map { |num| num.to_i }
    @evo = evo_proc(@evo)
    puts
    @types = get_info(self.prompt_mint(3)).split('-')
    @types = false if @types == []
    puts
    @legend = get_info(self.prompt_mint(4))
    puts
    case @legend
    when ''
      @legend = nil
    when 'yes'
      @legend = true
    when 'no'
      @legend = false
    end
  end
end

territory = DiscoverArea.new
territory.enter_area
atteributes = territory.instance_variables.select { |sym| sym != :@prompt  }
#p atteributes
atteributes.map! { |attr| territory.instance_variable_get(attr) }
area = ExploreArea.new(atteributes)
area.set_location
area.set_dex
