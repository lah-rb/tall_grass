require_relative '../dir_manager.rb'
require_relative '../prompt.rb'
require_relative '../backend/expedition.rb'


class Explorer
  include Prompt

  def initialize
    DirManager.new('tall_grass')
    Expedition.new(get_info("Where are you looking to explore again? "))
  end
end
