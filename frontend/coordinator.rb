require_relative '../prompt.rb'
require_relative '../backend/venue.rb'
require_relative 'managers_assistant.rb'


class Coordinator
  include ManagersAssistant
  include Prompt

  def initialize
    @event_space = Venue.new
  end

  def which_event
    @event_space.list_events
    @completed_event = get_info(
      "Which mission has been completed?",
      'input options: int, r, return')

    if not_in_range?(@completed_event, @event_space.events_arr)
      display "I am sorry we didn't plan for that event. Submit it through GitHub!"
    else
      case @completed_event.chr
      when 'r', 'c'
        @event_space.reset_all
      else
         @event_space.complete_event(@completed_event.to_i)
      end
    end
  end
end
