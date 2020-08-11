require_relative '../dir_manager.rb'
require_relative '../prompt.rb'
require_relative 'dex.rb'
require_relative 'dex_maker_toolbox.rb'

class Venue
  include Prompt

  attr_reader :events

  def initialize
    @director = DirManager.new
    @director.request_dir('backend')
    @events_path = './dex_store/events_dex'
    current_events
  end

  def current_events
    @director.request_dir('backend')
    @events = Dex.compile_dex(@events_path, true)
  end

  def complete_with_string(completed_event)
    complete_event(
      events.find_index do |event|
        event.first == completed_event.gsub(' ', '_').downcase
      end
    )
  end

  def complete_with_num(completed_event)
    complete_event(completed_event - 1)
  end

  def write_reset
    @director.request_dir('backend')
    DexMakerToolbox.write_dex(reset_all, @events_path)
  end

  private

  def complete_event(event_num)
    events[event_num][1] = 'complete'
    DexMakerToolbox.write_dex(events, @events_path)
  end

  def reset_all
    Dex.compile_dex(@events_path, true).reduce([]) do |reset_dex, old_dex|
      reset_dex << [old_dex.first, ['incomplete']]
    end
  end
end
