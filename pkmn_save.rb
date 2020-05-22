require 'fileutils'

class Save
  def mint_navigation_arr(source_parent, target_parent)
    @source_seeds = Dir[source_parent + "dex_seeds/*"]
    @source_store = Dir[source_parent + "dex_store/*"]
    @target_seeds = Dir[target_parent + "dex_seeds/*"]
    @target_store = Dir[target_parent + "dex_store/*"]
    @source_arr = @source_seeds + @source_store
    @target_arr = @target_seeds + @target_store
    return [@source_arr, @target_arr, source_parent, target_parent]
  end

  def load_save_attr(load_or_save, save_name = 'temp')
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

  def fill_save(ls_arr)
    ls_arr[2].each do |target_file|
      @end_path = target_file.split("/").values_at(-2, -1).join("/")
      @target_file = ls_arr[4] + @end_path
      FileUtils.rm(@target_file)
    end

    ls_arr[1].each do |source_file|
      @end_path = source_file.split("/").values_at(-2, -1).join("/")
      @target_file = ls_arr[4] + @end_path
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

  def new_save
    puts
    print 'Please give a name to this save: '
    @save_name = STDIN.gets.chomp.downcase.split(" ").join("_")

    FileUtils.cd('./saves')
    FileUtils.mkdir(@save_name)
    FileUtils.cd(@save_name)
    FileUtils.mkdir("dex_seeds")
    FileUtils.mkdir("dex_store")
    FileUtils.cd("..")
    FileUtils.cd("..")

    @ls_arr = load_save_attr('s', @save_name)
    show_progress(@ls_arr[0])
    fill_save(@ls_arr)
    puts 'Done!'
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
      @count = 0
      @current_saves.each do |save|
        @count += 1
        puts @count.to_s + " - " + save.split("/").pop.gsub("_"," ")
      end
    end
    return @current_saves
  end

  def over_load(load_or_save)
    @current_saves = list_saves
    exit if @current_saves == []
    @method = load_save_attr(load_or_save)[0]
    puts
    print "Give the number of the save you wish to " + @method + ": "
    @save_num = STDIN.gets.chomp.to_i
    @save_name = @current_saves[@save_num - 1].split('/')[-1]
    @ls_arr = load_save_attr(load_or_save, @save_name)
    show_progress(@method)
    fill_save(@ls_arr)
    puts "Done!"
  end
end

puts "Would you like to start, overwrite, or load an advenure?"
print "Input options: "
print "new or n - new save"
print "over or o - overwrite save"
puts "load or l - load save"
@save_method = STDIN.gets.chomp.downcase

case @save_method
when 'new', 'n'
  Save.new.new_save
when 'over', 'o'
  Save.new.over_load('o')
when 'load', 'l'
  Save.new.over_load('l')
else
  puts "I am sorry I don't know that input."
end
