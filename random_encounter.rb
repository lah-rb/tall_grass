require './dex.rb'

puts Dex::pokedex["#{rand(0...Dex::pokedex.size)}"][0]
