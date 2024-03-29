require 'fileutils'
require_relative '../dir_manager.rb'
require_relative '../prompt.rb'

class Save
  include Prompt
  prepend FileUtils
  public

  def initialize()
    @director = DirManager.new
    @director.request_dir('backend')
  end

  def backup
    mkdir("../../.tall_grass_games_backup") unless Dir.glob('../../*', File::FNM_DOTMATCH).include?("../../.tall_grass_games_backup")
    cp_r('./saves', "../../.tall_grass_games_backup/" + Time.now.strftime("%e-%m-%y-%I-%M-%S"))
  end

  def new_save(save_name)
    @save_name = save_name.gsub('/', '')
    cd('saves')
    begin
      mkdir(@save_name)
    rescue
      cd('..')
      raise(Errno::EEXIST)
    end
    cd(@save_name)
    mkdir("dex_seeds")
    mkdir("dex_store")
    cd("../..")
    save_to = "./saves/" + save_name + "/"
    @save_arr = mint_load_save_arr(:new, save_to)
    show(progress(@save_arr[0]))
    fill_save(@save_arr)
    puts 'Done!'
  end

  def over_load(load_or_save, save_num)
    @save_name = get_save_name(save_num)
    save_to = "./saves/" + @save_name + "/"
    @over_load_arr = mint_load_save_arr(load_or_save, save_to)
    @method = @over_load_arr[0]
    show(progress(@method))
    fill_save(@over_load_arr)
    puts 'Done!'
  end

  def delete_save(save_num)
    @save_name = get_save_name(save_num)
    show(progress('delete'))
    cd('saves')
    rm_r(@save_name, secure: true)
    puts 'Done!'
    cd('..')
  end

  def current_saves
    Dir['./saves/*'].sort
  end

  def get_save_name(save_num)
    unless current_saves[save_num].nil?
      return current_saves[save_num].split('/')[-1]
    else
      return -1
    end
  end

  def list_saves
    @saves = current_saves.map { |save| file_name_to_title(save.split("/").pop) }
    show_list(@saves, "List of current save states:")
    return current_saves
  end

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

  def mint_load_save_arr(load_or_save, saves_dir)
    case load_or_save
    when :new, :overwrite
      @method = 'save' if load_or_save == :new
      @method = 'overwrite' if load_or_save == :overwrite
      @source_parent = "./"
      @target_parent = saves_dir
      [@method] + mint_navigation_arr(@source_parent, @target_parent)
    when :load
      @method = 'load'
      @source_parent = saves_dir
      @target_parent = "./"
      [@method] + mint_navigation_arr(@source_parent, @target_parent)
    end
  end

  def fill_save(nav_arr)
    # Wreck target directory
    nav_arr[2].each do |target_file|
      @end_path = target_file.split("/").values_at(-2, -1).join("/")
      @target_file = nav_arr[4] + @end_path
      rm(@target_file)
    end
    # Rewrite target directory
    nav_arr[1].each do |source_file|
      @end_path = source_file.split("/").values_at(-2, -1).join("/")
      @target_file = nav_arr[4] + @end_path
      cp(source_file, @target_file)
    end
  end

  def progress(action)
    if action[-1] == 'e'
      action.capitalize.chop + 'ing ' + file_name_to_title(@save_name) + '...'
    else
      action.capitalize + 'ing ' + file_name_to_title(@save_name) + '...'
    end
  end
end
