require_relative 'dir_manager.rb'
require_relative 'prompt.rb'
Dir['frontend/*'].each { |script| require_relative script }

class Runner
  include Prompt

  def initialize
    @director = DirManager.new
    @tall_grass = Encounter.new
    @pioneer = Pioneer.new
    @saver = Saver.new
    @explorer = Explorer.new
    @coordinator = Coordinator.new
    @librarian = Librarian.new
    @shop_keeper = ShopKeeper.new
  end

  def employ(object = nil)
    sleep(1.5)
    run
  end

  def run
    @director.request_dir('tall_grass')

    case get_info(prompt_mint(:runmenu), 'Hit return to exit').chr.downcase
    when 'e'
      employ @tall_grass.look_for_trouble
    when 'n'
      employ @pioneer.make_landing
    when 's'
      employ @saver.start_saving
    when 'r'
      employ @explorer.make_landing
    when 'm'
      employ @coordinator.which_event
    when 'i'
      employ @librarian.look_up
    when 'g'
      employ @shop_keeper.checkout_good
    when 'c'
      employ @shop_keeper.checkout_cart
    end
  end
end

Runner.new.run
