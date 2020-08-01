module Prompt
  public

  def get_info(prompt, message = '')
    puts
    puts prompt
    print "<#{message}> "
    $stdin.gets.chomp
  end

  def continue?(statement = "Continue?")
    case get_info(statement, "y/return").downcase
    when 'y', 'yes'
      return true
    else
      return false
    end
  end

  def display(message)
    puts
    puts message
  end

  def display_list(display_arr, descriptor_string, index_start = 1)
    display descriptor_string
    display_arr.each.with_index(index_start) do |item, index|
      puts index.to_s + ": " + item
    end
  end

  def file_name_to_title(file_name)
    @title = file_name.split("_")

    @title.each do |word|
      case word
      when @title[0]
        word.capitalize!
      when *articles_bverbs_conjunctions_prepositions
        word
      else
        word.capitalize!
      end
    end

    return @title.join(" ")
  end

  def prompt_mint(sym, variable_string = '')
    prompt_store(variable_string.to_s)[sym].gsub('      ', '')
  end

  private

  def articles_bverbs_conjunctions_prepositions
    [
      "a", "an", "the", "am", "is", "was", "were", "be", "being", "been",
      "and", "but", "or", "nor", "for", "yet", "so",
      "amid", "anti", "as", "at", "by", "down", "from", "in",
      "into", "like", "near", "of", "off", "on", "onto", "over", "per",
      "than", "to", "up", "upon", "via", "with"
    ]
  end

  def prompt_store(variable_string)
    {
      specificmenu:
      "Do you see any specific pokemon?
      Input by pokedex number: 1-2-3
      If there are no specific pokemon hit return",
      populationmenu:
      "How many species do you see?
      Input example: 14
      If you see no specific number hit return",
      evomenu:
      "What evolution stages are present?
      Input example: 2-3
      If you don't know what evolution stages are here hit return",
      presenttypes:
      "What types are present?
      Input example: water-fire-grass
      If you don't see any specific types hit return",
      absenttypes:
      "What types are not present?
      Input example: water-fire-grass
      If any type maybe here hit return",
      currentlocalmenu:
      "Current location: #{variable_string.gsub('_', ' ')}
      Any specific type?",
      tribemenu:
      "Do #{variable_string} exist here?
      Input options:
      only or o - A whole tribe lives here!
      yes or y - I see some here!
      no or n - I don't see any here.
      return - Some may or may not exist here",
      conflictmenu:
      "In the case of conflict will evolution or pokemon distinction take priority?
      Input options:
      dist or d - prefer keeping distinctions over evolution stage (default)
      evo or e - prefer keeping evolution stage over distinctions
      return - accept the default",
      evoegg:
      "While we encourage you to have eggs in your D&D night, \
      you don't really need us to generate them (Do you?!?).
      tall_grass just helps you decide what goes in the egg, \
      so don't ask us for stage 0 pokemon from now on.",
      evobad:
      "This program only considers evolution stages 1-3. #{variable_string} \
      contains a number not within this range.",
      savemenu:
      "Would you like to start, overwrite, load, or delete an advenure?
      Input options:
      new or n - new save
      over or o - overwrite save
      load or l - load save
      delete or d - permanently delete save",
      confirmdelete:
      "Are you sure that you want to DELETE #{variable_string}?
      This action cannot be undone.",
      emptydexpool:
      "There were not enough pokemon which meet requirements to fill \
      a pokedex of that size. The dex will be filled as much as possible",
      runmenu:
      "Welcome to tall_grass: A Pokemon D&D Adventure Aid!

      Would you like to:
      Encounter a Pokemon - e or encounter
      Make a New Area Dex - n or new
      Create a Save State - s or save
      Refresh an Area Dex - r or refresh
      Manage  Story Event - m or manage
      Gather Pokemon Info - i or info
      Get  trainer  goods - g or goods",
      randomurl:
      "https://www.random.org/integers/?\
      num=1&min=1&max=#{variable_string}&col=1&base=10&format=plain&rnd=new"
    }
  end
end
