class Distinctions
  # selector: baby, fossil, beast, legend, myth
  def initialize(selector)
    @selector = selector
    @only_parser = ''
    @grab_parser = ''
    @drop_parser = ''
  end

  def convert_to_regex
    @only_parser += '['
    @grab_parser += '['
    @drop_parser += '['

    case @selector.baby
    when 'o'
      @only_parser += '*|'
    when 'y'
      @grab_parser += '*|'
    when 'n'
      @drop_parser += '*|'
    end

    case @selector.fossil
    when 'o'
      @only_parser += '~|'
    when 'y'
      @grab_parser += '~|'
    when 'n'
      @drop_parser += '~|'
    end

    case @selector.beast
    when 'o'
      @only_parser += '#|'
    when 'y'
      @grab_parser += '#|'
    when 'n'
      @drop_parser += '#|'
    end

    case @selector.legend
    when 'o'
      @only_parser += '!|'
    when 'y'
      @grab_parser += '!|'
    when 'n'
      @drop_parser += '!|'
    end

    case @selector.myth
    when 'o'
      @only_parser += '"^"|'
    when 'y'
      @grab_parser += '"^"|'
    when 'n'
      @drop_parser += '"^"|'
    end

    @only_parser.slice!(-1)
    @grab_parser.slice!(-1)
    @drop_parser.slice!(-1)

    @only_parser += ']'
    @grab_parser += ']'
    @drop_parser += ']'

    @only_parser.size == 1 ? @only_parser = false : @only_parser = Regexp.new(@only_parser)
    @grab_parser.size == 1 ? @grab_parser = false : @grab_parser = Regexp.new(@grab_parser)
    @drop_parser.size == 1 ? @drop_parser = false : @drop_parser = Regexp.new(@drop_parser)

    return [@only_parser, @grab_parser, @drop_parser]
  end
end
