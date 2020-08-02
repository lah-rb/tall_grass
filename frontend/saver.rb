require_relative '../prompt.rb'
require_relative '../backend/save.rb'

class Saver
  include Prompt
  public

  def start_saving
    @save_method = get_info(prompt_mint(:savemenu)).chr.downcase
    @save = Save.new


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
      @save_num = over_load_del_input('overwrite')
      if @save_num == -1 || @save_num > @saves_size -1
        display "That's not on the list."
      elsif @save_num == -2
        display "Let's create a new save!"
        @save.new_save(new_save_input)
      else
        @save.over_load(:overwrite, @save_num)
      end
    when 'l'
      @save_num = over_load_del_input('load')
      if @save_num == -1 || @save_num > @saves_size -1
        display "That's not on the list."
      elsif @save_num == -2
        display "Let's create a new save!"
        @save.new_save(new_save_input)
      else
        @save.over_load(:load, @save_num)
      end
    when 'd'
      @save_num = insure_correct(over_load_del_input('delete'))
      @save.delete_save(@save_num) unless @save_num == -1 || @save_num > @saves_size -1
    else
      display "I am sorry I don't know that input."
    end
  end

  private

  def insure_correct(save_num)
    unless save_num == -1 || save_num > @saves_size - 1 || save_num == -2
      @confirmation = get_info(
        prompt_mint(
          :confirmdelete,
          file_name_to_title(@save.get_save_name(save_num))
        ),
        'Y/n'
      )
    else
      @confirmation = 'n'
    end

    case @confirmation
    when 'Y'
      return save_num
    else
      display 'No save was deleted. Enter a capital "Y" to delete the save.'
      return -1
    end
  end

  def check_empty
    @current_saves = @save.current_saves
    @saves_size = @save.current_saves.size

    if @current_saves.empty?
      display "There are no existing saves."
      return -2
    end
  end

  def new_save_input
    get_info('Please give a name to this save: ').downcase.split(" ").join("_")
  end

  def over_load_del_input(method)
    @save.list_saves
    @check = check_empty
    return @check if @check == -2
    get_info("Give the number of the save you wish to #{method}: ").to_i - 1
  end
end
