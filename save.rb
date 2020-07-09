require_relative './backend/save_manager.rb'
require_relative 'prompt.rb'

class Save
  include Prompt
  public

  def initialize
    @save_method = get_info(prompt_mint(11)).chr.downcase

    @save = SaveManager.new

    case @save_method
    when 'n'
      begin
        @save.new_save(new_save_input)
      rescue(Errno::EEXIST)
        display 'That file name already exists. Please pick new name.'
        @save.list_saves
        @save.new_save(new_save_input)
      end
    when 'o'
      @save.over_load(:overwrite, over_load_del_input('overwrite'))
    when 'l'
      @save.over_load(:load, over_load_del_input('load'))
    when 'd'
      @save.delete_save(insure_correct(over_load_del_input('delete')))
    else
      display "I am sorry I don't know that input."
    end
  end

  private

  def insure_correct(save_num)
    case get_info(prompt_mint(12, @save.get_save_name(save_num)))
    when 'Y'
      return save_num
    else
      display 'No save was deleted. Enter a capital "Y" to delete the save.'
      exit
    end
  end

  def check_save_dir
    @current_saves = @save.current_saves

    if @current_saves.empty?
      display "There are no existing saves. Let's make a new save."
      @save.new_save(new_save_input)
      exit
    end
  end

  def new_save_input
    get_info('Please give a name to this save: ').downcase.split(" ").join("_")
  end

  def over_load_del_input(method)
    @save.list_saves
    check_save_dir
    get_info("Give the number of the save you wish to #{method}: ").to_i - 1
  end
end

Save.new
