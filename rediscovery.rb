require_relative 'prompt.rb'
require_relative './backend/rediscover_area.rb'


class Rediscovery
  include Prompt

  def reobserve_area
    @land_name = get_info("Where are you looking to explore again? ")
    RediscoveredArea.new(@land_name)
  end
end

Rediscovery.new.reobserve_area
