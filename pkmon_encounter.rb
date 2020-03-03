@area_dex = []
@type_dex = []

print "Where are you? "
@area = "./" + STDIN.gets.chomp + ".txt"

print "Any specific type? "
@type = STDIN.gets.chomp.capitalize

File.open("#{@area}", 'r') do |f|
  while record = f.gets
    @species = record.chomp
    @area_dex << @species
  end
end

if @type.chomp.empty?
  puts @area_dex[rand(0...@area_dex.size)]
else
  @area_dex.each do |entry|
    if entry.split("-")[2] == @type || entry.split("-")[3] == @type
      @type_dex << entry.split("-")[0]
    end
  end
  puts @type_dex[rand(0...@type_dex.size)]
end
