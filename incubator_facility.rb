require './dex_maker.rb'

class IncubatorFacility
  include DexMaker

  DexMaker::dex_pool
  DexMaker::limit_pool(20)

  File.open('./incubator_facility.txt', 'w') do |new_dex|
    DexMaker::que.each {|entry| new_dex.puts(entry)}
  end
end
