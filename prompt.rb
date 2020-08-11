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

  def show(message)
    puts
    puts message
  end

  def show_list(show_arr, descriptor_string, index_start = 1)
    show descriptor_string
    show_arr.each.with_index(index_start) do |item, index|
      puts index.to_s + ": " + item.to_s
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

  def area_from_list(all_locals, *prompt)
    show_list(
      all_locals.map { |local| file_name_to_title local },
      'Here is what we know so far:'
    )
    get_info(*prompt).downcase.gsub(" ", "_")
  end

  def prompt_mint(sym, *var_arr)
    prompt_store(var_arr)[sym].gsub('      ', '')
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

  def prompt_store(var_arr)
    {
      runmenu:
      "Welcome to tall_grass: A Pokemon D&D Adventure Aid!

      Would you like to:
      Encounter a Pokemon - e or encounter
      Make a New Area Dex - n or new
      Create a Save State - s or save
      Refresh an Area Dex - r or refresh
      View   an  Area Dex - v or view
      Manage  Story Event - m or manage
      Gather Pokemon Info - i or info
      Get  Trainer  Goods - g or goods
      Get a Cart of Goods - c or cart
      Encounter a Trainer - t or trainer",
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
      "Current location: #{var_arr[0].gsub('_', ' ') unless var_arr[0].nil?}
      Any specific type?",
      tribemenu:
      "Do #{var_arr[0]} exist here?
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
      evobad:
      "This program only considers evolution stages 1-3. #{var_arr[0]} \
      contains a number not within this range.",
      savemenu:
      "Would you like to start, overwrite, load, or delete an adventure?
      Input options:
      new or n - new save
      over or o - overwrite save
      load or l - load save
      delete or d - permanently delete save",
      confirmdelete:
      "Are you sure that you want to DELETE #{var_arr[0]}?
      This action cannot be undone.",
      emptydexpool:
      "There were not enough pokemon which meet requirements to fill \
      a pokedex of that size. The dex will be filled as much as possible",
      comptrainer:
      "Your competition is #{var_arr[0]} #{var_arr[1]} \
      and here is their team!",
      pkmninfo:
      "#{var_arr[0]} is \
      #{var_arr[1]}. This pokemon is at evolution stage \
      #{var_arr[2]} and is typed as #{var_arr[3]}\
      #{"-" + var_arr[4] unless var_arr[4] == '%' || var_arr[4].nil?}.",
    }
  end
end
