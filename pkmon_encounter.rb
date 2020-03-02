@area_dex = []
print "Where are you? "
@area = "./" + STDIN.gets.chomp + ".txt"

File.open("#{@area}", 'r') do |f|
  while record = f.gets
    @species = record.chomp
    @area_dex << @species
  end
end

puts @area_dex[rand(0...@area_dex.size)]
