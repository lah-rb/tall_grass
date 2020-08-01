require_relative 'dir_manager.rb'
require_relative 'prompt.rb'
Dir['frontend/*'].each { |script| require_relative script }

class Runner
  include Prompt

  def initialize
    run
  end

  def hire(object)
    sleep(2)
    run
  end

  def run
    @director = DirManager.new
    @director.request_dir('tall_grass')
    @tall_grass = Encounter.new
    @shop_keeper = ShopKeeper.new
    @coordinator = Coordinator.new

    case get_info(prompt_mint(:runmenu), 'Hit return to exit').chr.downcase
    when 'e'
      hire @tall_grass.look_for_trouble
    when 'n'
      hire Pioneer.new
    when 's'
      hire Save.new
    when 'r'
      hire Explorer.new
    when 'm'
      hire @coordinator.which_event
    when 'i'
      hire Librarian.new
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

Runner.new
