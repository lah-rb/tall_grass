require "./explore_area.rb"
print "Where are you looking to explore again? "
@seed = STDIN.gets.chomp.downcase.split(" ").join("_")
File.open("./dex_seed/" + @seed, "r") { |file| @attributes = file.gets }
ExploreArea.new(eval(@attributes))
