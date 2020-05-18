require './dex.rb'
require './dex_maker.rb'

class ManageEvents
  @@events_path = $store + "events_dex"

  def list_events
    @num = 0
    @events = Dex::compile_dex(@@events_path)
    @events.each do |event|
      @num += 1
      @title = event[0].split("_")

      @title.each do |word|
        case word
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
      puts @num.to_s + ': ' + @title + @completeness
    end
  end

  def complete_event
    list_events
    puts
    print 'Which mission has been completed? (hit return to exit) '
    @completed_event = STDIN.gets.chomp.to_i
    if @completed_event != 0
      @completed_event = @completed_event - 1
      @events[@completed_event][1] = '$'
      DexMaker::write_dex(@events, @@events_path)
    end
  end
  def reset_all
    @events = Dex::compile_dex(@@events_path)
    @events.each do |arr|
      arr[1] = '*'
    end
    DexMaker::write_dex(@events, @@events_path)
  end
end

manager = ManageEvents.new
manager.complete_event
