require 'fileutils'
require_relative 'prompt.rb'
require_relative '../rediscover_area.rb'


class Rediscovery
  include Prompt
  
  def initialize
    FileUtils.cd('..')
  end

  def reobserve_area
    @land_name = get_info("Where are you looking to explore again? ")
    RediscoveredArea.new(@land_name)
  end
end

Rediscovery.new.reobserve_area
