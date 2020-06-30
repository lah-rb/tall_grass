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

  def prompt_mint(num, var = '')
    prompt_store(var)[num].split("      ").join
  end

  private

  def prompt_store(var)
    ["Do you see any specific pokemon?
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
     "Do legendary exist here?
      Input options:
      only or o - only legendary exist here
      yes or y - some legendary exist here
      no or n - no legendary exist here
      return - some legendary may or may not exist here  ", #4
      "What do you want to call this new area? ", #5
      "What types are not present?
       Input example: water-fire-grass
       If any type maybe here hit return. ", #6
      'Which mission has been completed?
       (type reset to clear events or hit return to exit) ', #7
      "Current location: #{var.gsub('_', ' ')}
       Any specific type? (Hit return for no type) "] #8
  end
end
