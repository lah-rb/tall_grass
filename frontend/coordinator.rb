require_relative '../prompt.rb'
require_relative '../backend/venue.rb'


class Coordinator
  include Prompt

  def initialize
    @event_space = Venue.new
  end

  def not_in_range?
    smaller_than_arr = @completed_num > @event_space.events_arr.size
    is_a_string_number = @completed_num.to_s == @completed_event
    (smaller_than_arr || !@completed_num.positive?) && is_a_string_number
  end

  def which_event
    @event_space.list_events
    @completed_event = get_info(
      "Which mission has been completed?",
      'input options: int, r, return')
    @completed_num = @completed_event.to_i

    if not_in_range?
      display "I am sorry we didn't plan for that event. Submit it through GitHub!"
    else
      case @completed_event
      when 'r', 'c', 'reset', 'clear'
        @event_space.reset_all
      else
         @event_space.complete_event(@completed_event.to_i)

      end
    end
  end
end
