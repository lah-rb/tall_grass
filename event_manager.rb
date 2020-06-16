require_relative 'dex.rb'
require_relative 'dex_maker.rb'

class EventManager

  def initialize
    @events_path = $store + "events_dex"
    @events = Dex::compile_dex(@events_path)
  end

  def list_events
    @events.each.with_index(1) do |event, i|
      @title = event[0].split("_")

      @title.each do |word|
        case word
        when @title[0]
          word.capitalize!
        when 'a', 'an', 'the', 'and', 'but', 'or', 'nor', 'for', 'as', 'at', 'by', 'in', 'of', 'on', 'to'
          word
        else
          word.capitalize!
        end
      end

      @title = @title.join(" ")

      case event[1]
      when '*'
        @completeness = ' - incomplete'
      when '$'
        @completeness = ' - complete'
      end

      puts
      puts i.to_s + ': ' + @title + @completeness
    end
  end

  def complete_event(completed_event = 0)
    if completed_event != 0
      completed_event -= 1
      @events[completed_event][1] = '$'
      DexMaker::write_dex(@events, @events_path)
    end
  end

  def reset_all
    @events = Dex::compile_dex(@events_path)
    @events.each do |arr|
      arr[1] = '*'
    end
    DexMaker::write_dex(@events, @events_path)
  end
end
