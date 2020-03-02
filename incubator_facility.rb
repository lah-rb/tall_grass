require './dex_maker.rb'

class IncubatorFacility
  include DexMaker

  @criteria = Proc.new {
    |num, entry|
      if entry[1] == "1" && entry[0].split("").pop.match?(/["^"|!|#]/) == false
        DexMaker::new_dex << entry[0]
      end
  }

  DexMaker::dex_pool(@criteria)
  DexMaker::limit_pool(20)

  File.open('./incubator_facility.txt', 'w') do |new_dex|
    DexMaker::que.each {|entry| new_dex.puts(entry)}
  end
end
