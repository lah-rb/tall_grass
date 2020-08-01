require_relative '../dir_manager.rb'
require_relative '../prompt.rb'
require_relative 'dex.rb'
require_relative 'dex_maker_toolbox.rb'

class Venue
  include Prompt

  def initialize
    @director = DirManager.new
    @director.request_dir('backend')
    @events_path = './dex_store/' + "events_dex"
    @events = Dex.compile_dex(@events_path, true)
  end

  def list_events
    @interpreted = @events.each.map do |event|
      @title = file_name_to_title(event[0])

      case event[1]
      when '*'
        @completeness = ' - incomplete'
      when '$'
        @completeness = ' - complete'
      end
      event = @title + @completeness
    end

    display_list(@interpreted, 'Current events:')
  end

  def events_arr
    @interpreted
  end

  def complete_event(completed_event = 0)
    unless completed_event == 0
      completed_event -= 1
      @events[completed_event][1] = '$'
      DexMakerToolbox.write_dex(@events, @events_path)
    end
  end

  def reset_all
    @events = Dex.compile_dex(@events_path, true).reduce([]) do |reset_dex, old_dex|
      reset_dex << [old_dex[0], ['*']]
    end

    DexMakerToolbox.write_dex(@events, @events_path)
  end
end
