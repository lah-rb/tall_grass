require 'fileutils'
require_relative 'prompt.rb'
require_relative '../event_manager.rb'


class Coordinator
  include Prompt

  def initialize
    FileUtils.cd('..')
    @planner = EventManager.new
    which_event
  end

  def which_event
    @planner.list_events
    @completed_event = get_info(prompt_mint(7))
    case @completed_event
    when 'r', 'c', 'reset', 'clear'
      @planner.reset_all
    else
      @planner.complete_event(@completed_event.to_i)
    end
  end
end

Coordinator.new