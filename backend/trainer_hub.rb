require_relative 'trainer.rb'
require_relative 'dex.rb'
require_relative 'dex_maker_toolbox.rb'
require_relative 'evo.rb'
require_relative '../dir_manager.rb'
require_relative '../backend/natures.rb'

class TrainerHub
  include Dex
  include DexMakerToolbox

  Natures = Natures.new

  Types = [
    'Normal', 'Fire', 'Water', 'Grass', 'Electric', 'Ice', 'Fighting', 'Poison',
    'Ground', 'Flying', 'Psychic', 'Bug', 'Rock', 'Ghost', 'Dragon', 'Dark',
    'Steel', 'Fairy', ''
  ]

  TrainerJob = {
    "Normal"=>"Veteran", "Fire"=>"Kindler", "Water"=>"Sailor", "Grass"=>"Gardener",
    "Electric"=>"Super Nerd", "Ice"=>"Cool trainer", "Fighting"=>"Blackbelt",
    "Poison"=>"Scientist", "Ground"=>"Expert", "Flying"=>"Bird Keeper",
    "Psychic"=>"Psychic", "Bug"=>"Bug Catcher", "Rock"=>"Hiker",
    "Ghost"=>"Channeler", "Dragon"=>"Dragon Tamer", "Dark"=>"Burgler",
    "Steel"=>"Engineer", "Fairy"=>"Dancer", ""=>"Ace Trainer"
  }

  EvoCombos = Evo.all_acceptable_evos.keep_if { |arr| arr.size < 3 } << []

  def initialize
    @director = DirManager.new
    @director.request_dir('backend')
    @dex = Dex.pokedex
    @names_arr = File.open("gyms/names", "r") do |file|
      file.reduce([]) do |store, line|
        store << line.chomp.capitalize
        store
      end
    end
  end

  def random_party(fav_type)
    @director.request_dir('backend')
    DexMakerToolbox.set_refine

    party_size = rand(1..6)
    evo_seed = rand(0...EvoCombos.size)

    type_arr = []
    type_arr << fav_type unless fav_type.empty?
    type_arr << "|"

    filtered_pool = DexMakerToolbox.filter_dex(
      @dex,
      Evo.new(EvoCombos.to_a[evo_seed]),
      type_arr,
      [false, false, /[#|!|"^"]/],
      :evo
    )

    DexMakerToolbox.limit_pool(filtered_pool, party_size).map { |poke| [poke, Natures.give_random] }
  end

  def train_trainer(name, type, party)
    new_trainer = Trainer.new(name)
    new_trainer.prefered_type = type
    new_trainer.job = TrainerJob[type]
    new_trainer.party = party
    return new_trainer
  end

  def random_trainer(random_type = Types[rand(0...Types.size)])
    train_trainer(
      @names_arr[rand(0...@names_arr.size)],
      random_type,
      random_party(random_type)
    )
  end

  def random_gym
    size = rand(3..6)
    type = Types[rand(0...Types.size)]
    (1..size).reduce([]) do |store|
      if type.empty?
        store << random_trainer
      else
        store << random_trainer(type)
      end
      store
    end
  end

  def build_gym(trainers, file_name)
    trainer_ids = trainers.map do |trainer|
      {
        name: trainer.name,
        job: trainer.job,
        prefered_type: trainer.prefered_type,
        party: trainer.party.map { |member| member.to_a }
      }
    end

    File.open('gyms/' + file_name, 'w') do |line|
      line.puts "module Gym"
      line.puts "  def gym"
      line.puts "    @gym = ["
      trainer_ids.each do |id|
        line.print "      "
        line.print id
        line.puts ","
      end
      line.puts "    ]"
      line.puts "  end"
      line.print "end"
    end
  end

  def challenge(hangout)
    require_relative('gyms/' + hangout)
    self.class.include Gym
      gym.map do |member|
        member[:party].map! { |pkmn| Dex.entry(*pkmn) }
        train_trainer(
          member[:name],
          member[:prefered_type],
          member[:party]
        )
    end
  end
end

__END__
@hub = TrainerHub.new
@hub.build_gym(@hub.random_gym, 'random_gym.rb')
puts @hub.challenge('random_gym.rb')
