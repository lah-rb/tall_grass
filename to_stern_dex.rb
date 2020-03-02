require './dex_maker.rb'

class ToStern
  include DexMaker

  @criteria = Proc.new {
    |num, entry|
    if entry[1] != "3" && entry[0].split("").pop.match?(/["^"|!|#]/) == false
      DexMaker::new_dex << entry[0]
    end
  }

  DexMaker::dex_pool(@criteria)
  DexMaker::limit_pool(20)

  File.open('./to_stern.txt', 'w') do |new_dex|
    DexMaker::que.each {|entry| new_dex.puts(entry)}
  end
end
