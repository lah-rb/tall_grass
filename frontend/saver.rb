require_relative '../prompt.rb'
require_relative '../backend/save.rb'

class Saver
  include Prompt
  public

  def start_saving
    @save = Save.new
    @save.list_saves
    @save_method = get_info(prompt_mint(:savemenu)).chr.downcase

    case @save_method
    when 'n'
      begin
        @save.new_save(new_save_input)
      rescue(Errno::EEXIST)
        show 'That file name already exists. Please pick new name.'
        @save.list_saves
        @save.new_save(new_save_input)
      end
    when 'o'
      @save_num = over_load_del_input('overwrite')
      if @save_num == -1 || @save_num > @saves_size -1
        show "That's not on the list."
      elsif @save_num == -2
        show "Let's create a new save!"
        @save.new_save(new_save_input)
      else
        @save.over_load(:overwrite, @save_num)
      end
    when 'l'
      @save_num = over_load_del_input('load')
      if @save_num == -1 || @save_num > @saves_size -1
        show "That's not on the list."
      elsif @save_num == -2
        show "Let's create a new save!"
        @save.new_save(new_save_input)
      else
        @save.over_load(:load, @save_num)
      end
    when 'd'
      @save_num = insure_correct(over_load_del_input('delete'))
      @save.delete_save(@save_num) unless @save_num == -1 || @save_num > @saves_size -1
    when 'b'
      @save.backup
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
      show 'No save was deleted. Enter a capital "Y" to delete the save.'
      return -1
    end
  end

  def check_empty
    @current_saves = @save.current_saves
    @saves_size = @save.current_saves.size

    if @current_saves.empty?
      show "There are no existing saves."
      return -2
    end
  end

  def new_save_input
    proto_name = get_info('Please give a name to this save: ').downcase.split(" ").join("_")
    proto_name == '' ? 'temp' : proto_name
  end

  def over_load_del_input(method)
    @save.list_saves
    @check = check_empty
    return @check if @check == -2
    get_info("Give the number of the save you wish to #{method}: ").to_i - 1
  end
end
