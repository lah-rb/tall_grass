require_relative '../prompt.rb'
require_relative '../backend/venue.rb'
require_relative '../managers_assistant.rb'


class Coordinator
  include ManagersAssistant
  include Prompt

  def initialize
    @event_space = Venue.new
  end

  def which_event
    @completed_event = area_from_list(
      @event_space.current_events.map { |event| event.join(' - ')},
      "Which mission has been completed?",
      'input options: int, r, return'
    )
    @completed_num = @completed_event.to_i

    if not_in_range?(@completed_event, @event_space.current_events)
      show "I am sorry we didn't plan for that event. Submit it through GitHub!"
    elsif @completed_num.to_s == @completed_event
      @event_space.complete_with_num(@completed_num)
    elsif @event_space.current_events.include?([@completed_event, 'incomplete'])
      @event_space.complete_with_string(@completed_event)
    elsif @completed_event.chr == 'r'
      @event_space.write_reset
    end
  end
end
