require './dex.rb'
@seed = rand(0...Dex::pokedex.size)

puts Dex::pokedex[@seed][1] + " No. " +  Dex::pokedex[@seed][0]
