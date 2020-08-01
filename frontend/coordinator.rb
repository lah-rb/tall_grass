require_relative '../prompt.rb'
require_relative '../backend/venue.rb'


class Coordinator
  include Prompt

  def initialize
    @planner = Venue.new
    which_event
  end

  def which_event
    @planner.list_events
    @completed_event = get_info(
      "Which mission has been completed?",
      'type reset to clear events or hit return to exit')
    case @completed_event
    when 'r', 'c', 'reset', 'clear'
      @planner.reset_all
    else
      @planner.complete_event(@completed_event.to_i)
    end
  end
end
