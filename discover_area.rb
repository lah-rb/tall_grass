require './area_maker.rb'

class DiscoverArea
  def self.name_area(prompt)
    print prompt
    STDIN.gets.chomp.downcase.split(" ").join("_")
  end

  def self.enter_area
    @area_name = name_area("What do you want to call this new land? ")
    
  end
end
