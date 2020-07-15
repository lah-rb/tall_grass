require_relative '../dir_manager.rb'
require_relative '../prompt.rb'
require_relative '../backend/expedition.rb'


class Explorer
  include Prompt

  def initialize
    @store = './dex_seeds/'
    @director = DirManager.new
    @director.request_dir('backend')
    Expedition.new(get_location("Where are you looking to explore again? ", /^.*[.]/, false))
  end
end
