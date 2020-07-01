require_relative 'prompt.rb'
require_relative './backend/rediscover_area.rb'


class Rediscovery
  include Prompt

  def reobserve_area
    RediscoveredArea.new(get_info("Where are you looking to explore again? "))
  end
end

Rediscovery.new.reobserve_area
