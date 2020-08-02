require_relative 'dir_manager.rb'
require_relative 'prompt.rb'
Dir['frontend/*'].each { |script| require_relative script }

class Runner
  include Prompt

  def hire(object)
    sleep(2)
    run
  end

  def run
    @director = DirManager.new
    @director.request_dir('tall_grass')
    @tall_grass = Encounter.new
    @pioneer = Pioneer.new
    @saver = Saver.new
    @explorer = Explorer.new
    @coordinator = Coordinator.new
    @librarian = Librarian.new
    @shop_keeper = ShopKeeper.new

    case get_info(prompt_mint(:runmenu), 'Hit return to exit').chr.downcase
    when 'e'
      hire @tall_grass.look_for_trouble
    when 'n'
      hire @pioneer.make_landing
    when 's'
      hire @saver.start_saving
    when 'r'
      hire @explorer.make_landing
    when 'm'
      hire @coordinator.which_event
    when 'i'
      hire @librarian.look_up
    when 'g'
      begin
        hire @shop_keeper.customer_service
      rescue SoftExit
        hire(nil)
        run
      end
    else
      exit
    end
  end
end

Runner.new.run
