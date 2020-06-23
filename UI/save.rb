require 'fileutils'

class Save
  FileUtils.cd('..')
  private

  def mint_navigation_arr(source_parent, target_parent)
    @source_seeds = Dir[source_parent + "dex_seeds/*"]
    @source_store = Dir[source_parent + "dex_store/*"]
    @target_seeds = Dir[target_parent + "dex_seeds/*"]
    @target_store = Dir[target_parent + "dex_store/*"]
    @source_arr = @source_seeds + @source_store
    @target_arr = @target_seeds + @target_store
    return [@source_arr, @target_arr, source_parent, target_parent]
  end

  def mint_load_save_arr(load_or_save, save_name = 'temp')
    case load_or_save
    when 's', 'o'
      @method = 'save' if load_or_save == 's'
      @method = 'overwrite' if load_or_save == 'o'
      @source_parent = "./"
      @target_parent = "./saves/" + save_name + "/"
      [@method] + mint_navigation_arr(@source_parent, @target_parent)
    when 'l'
      @method = 'load'
      @source_parent = "./saves/" + save_name + "/"
      @target_parent = "./"
      [@method] + mint_navigation_arr(@source_parent, @target_parent)
    end
  end

  def fill_save(nav_arr)
    # Wreck target directory
    nav_arr[2].each do |target_file|
      @end_path = target_file.split("/").values_at(-2, -1).join("/")
      @target_file = nav_arr[4] + @end_path
      FileUtils.rm(@target_file)
    end
    # Rewrite target directory
    nav_arr[1].each do |source_file|
      @end_path = source_file.split("/").values_at(-2, -1).join("/")
      @target_file = nav_arr[4] + @end_path
      FileUtils.cp(source_file, @target_file )
    end
  end

  def show_progress(action)
    if action[-1] == 'e'
      puts action.capitalize.chop + 'ing ' + @save_name.gsub("_"," ") + '...'
    else
      puts action.capitalize + 'ing ' + @save_name.gsub("_"," ") + '...'
    end
  end

  def list_saves
    @current_saves = Dir['./saves/*'].sort
    puts
    puts "List of current save states:"
    if @current_saves.empty?
      puts
      puts "There are no existing saves. Let's make a new save."
      new_save
    else
      @current_saves.each.with_index(1) do |save, count|
        puts count.to_s + " - " + save.split("/").pop.gsub("_"," ")
      end
    end
    return @current_saves
  end

  public

  def new_save
    puts
    print 'Please give a name to this save: '
    @save_name = $stdin.gets.chomp.downcase.split(" ").join("_")

    FileUtils.cd('./saves')
    FileUtils.mkdir(@save_name)
    FileUtils.cd(@save_name)
    FileUtils.mkdir("dex_seeds")
    FileUtils.mkdir("dex_store")
    FileUtils.cd("../..")

    @save_arr = mint_load_save_arr('s', @save_name)
    show_progress(@save_arr[0])
    fill_save(@save_arr)
    puts 'Done!'
  end

  def over_load(load_or_save)
    @current_saves = list_saves
    exit if @current_saves == []
    @method = mint_load_save_arr(load_or_save)[0]
    puts
    print "Give the number of the save you wish to " + @method + ": "
    @save_num = $stdin.gets.chomp.to_i - 1
    @save_name = @current_saves[@save_num].split('/')[-1]
    @over_load_arr = mint_load_save_arr(load_or_save, @save_name)
    show_progress(@method)
    fill_save(@over_load_arr)
    puts "Done!"
  end
end

def start_saving
  puts "Would you like to start, overwrite, or load an advenure?"
  print "Input options: "
  print "new or n - new save"
  print "over or o - overwrite save"
  puts "load or l - load save"
  @save_method = $stdin.gets.chomp.downcase

  @save = Save.new

  case @save_method
  when 'new', 'n'
    @save.new_save
  when 'over', 'o'
    @save.over_load('o')
  when 'load', 'l'
    @save.over_load('l')
  else
    puts "I am sorry I don't know that input."
    start_saving
  end
end

start_saving
