require_relative '../managers_assistant.rb'

class Natures
  include ManagersAssistant
  NatureArr = [
    ["Adamant", "Attack", "Sp. Atk"],
    ["Bashful", "Sp. Atk", "Sp. Atk"],
    ["Bold", "Defense", "Attack"],
    ["Brave", "Attack", "Speed"],
    ["Calm", "Sp. Def", "Attack"],
    ["Careful", "Sp. Def", "Sp. Atk"],
    ["Docile", "Defense", "Defense"],
    ["Gentle", "Sp. Def", "Defense"],
    ["Hardy", "Attack", "Attack"],
    ["Hasty", "Speed", "Defense"],
    ["Impish", "Defense", "Sp. Atk"],
    ["Jolly", "Speed", "Sp. Atk"],
    ["Lax", "Defense", "Sp. Def"],
    ["Lonely", "Attack", "Defense"],
    ["Mild", "Sp. Atk", "Defense"],
    ["Modest", "Sp. Atk", "Attack"],
    ["Naive", "Speed", "Sp. Def"],
    ["Naughty", "Attack", "Sp. Def"],
    ["Quiet", "Sp. Atk", "Speed"],
    ["Quirky", "Sp. Def", "Sp. Def"],
    ["Rash", "Sp. Atk", "Sp. Def"],
    ["Relaxed", "Defense", "Speed"],
    ["Sassy", "Sp. Def", "Speed"],
    ["Serious", "Speed", "Speed"],
    ["Timid", "Speed", "Attack"]
  ]
  def give_random
    NatureArr[random_seed(NatureArr)][0]
  end
  def lookup(nature)
    nature.capitalize!
    NatureArr.select { |nature_arr| nature_arr.include?(nature) }.flatten
  end
end
