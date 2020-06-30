require_relative '../save_manager.rb'

class Save
  public

  def start_saving
    puts "Would you like to start, overwrite, or load an advenure?"
    print "Input options: "
    print "new or n - new save"
    print "over or o - overwrite save"
    puts "load or l - load save"
    @save_method = $stdin.gets.chomp.downcase

    @save = SaveManager.new

    case @save_method
    when 'new', 'n'
      @save.new_save(new_save_input)
    when 'over', 'o'
      @save.over_load('o', over_input)
    when 'load', 'l'
      @save.over_load('l', load_input)
    else
      puts
      puts "I am sorry I don't know that input."
      puts
      start_saving
    end
  end

  private

  def check_save_dir
    @current_saves = @save.current_saves

    if @current_saves.empty?
      puts
      puts "There are no existing saves. Let's make a new save."
      @save.new_save(new_save_input)
      exit
    end
  end

  def new_save_input
    puts
    print 'Please give a name to this save: '
    $stdin.gets.chomp.downcase.split(" ").join("_")
  end

  def over_input
    @save.list_saves
    check_save_dir
    puts
    print "Give the number of the save you wish to overwrite: "
    $stdin.gets.chomp.to_i - 1
  end

  def load_input
    @save.list_saves
    check_save_dir
    puts
    print "Give the number of the save you wish to load: "
    $stdin.gets.chomp.to_i - 1
  end
end

Save.new.start_saving
