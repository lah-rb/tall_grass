class Distinctions
  # decision: baby, fossil, beast, legend, myth
  def initialize(decision)
    @decision = decision
    @only_parser = '['
    @grab_parser = '['
    @drop_parser = '['
  end

  def open_shut(subject, regexp_comp)
    case subject
    when 'o'
      @only_parser += regexp_comp
    when 'y'
      @grab_parser += regexp_comp
    when 'n'
      @drop_parser += regexp_comp
    end
  end

  def finish_regexp(partial_regexp)
    partial_regexp.slice!(-1)
    partial_regexp += ']'
    partial_regexp.size == 1 ? false : Regexp.new(partial_regexp)
  end

  def convert_to_regex
    open_shut(@decision.baby, '*|')
    open_shut(@decision.fossil, '~|')
    open_shut(@decision.beast, '#|')
    open_shut(@decision.legend, '!|')
    open_shut(@decision.myth, '"^"|')

    [
      finish_regexp(@only_parser),
      finish_regexp(@grab_parser),
      finish_regexp(@drop_parser)
    ]
  end
end
