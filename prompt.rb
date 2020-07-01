module Prompt
  public

  def get_info(prompt)
    puts
    print prompt
    $stdin.gets.chomp
  end

  def display(message)
    puts
    puts message
  end

  def prompt_mint(num, variable_string = '')
    prompt_store(variable_string)[num].gsub('      ', '')
  end

  private

  def prompt_store(variable_string)
    [
      "Do you see any specific pokemon?
      Input by pokedex number: 1-2-3
      If there are no specific pokemon hit return. ", #0

      "How many species do you see?
      Input example: 14
      If you see no speccific number hit return. ", #1

      "What evolution stages are present?
      Input example: 2-3
      If you don't know what evolution stages are here hit return. ", #2

      "What types are present?
      Input example: water-fire-grass
      If you don't see any specific types hit return. ", #3

      "What types are not present?
      Input example: water-fire-grass
      If any type maybe here hit return. ", #4

      "Which mission has been completed?
      (type reset to clear events or hit return to exit) ", #5

      "Current location: #{variable_string.gsub('_', ' ')}
      Any specific type? (Hit return for no type) ", #6

      "Do #{variable_string} exist here?
      Input options:
      only or o - A whole tribe lives here!
      yes or y - I see some here!
      no or n - I don't see any here.
      return - Some may or may not exist here. ", #7

      "In the case of conflict will evolution or pokemon distinction take priority.
      Input options:
      dist or d - prefer keeping distinctions over evolution stage #default
      evo or e - prefer keeping evolution stage over distinctions
      return - accept the default. " #8
    ]
  end
end
