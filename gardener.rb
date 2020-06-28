class Gardener

  class PlanterBox < File
    alias_method :plant, :print
  end

  def plant_area_seed(area_seed)
    PlanterBox.open("./dex_seeds/" + area_seed[0] + '.rb', "w") do |soil|
      soil.puts "class NativeFruit"
      soil.puts "  def seed"
      soil.print "    "
      soil.plant area_seed
      soil.print "\n"
      soil.puts "  end"
      soil.puts "end"
    end
  end
end
