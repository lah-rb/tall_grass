class Evo
  def initialize(ints)
    @ints = ints
    find_proc_args
  end

  def self.to_proc
    if @@compair_against
      Proc.new { |entry| @@compairson_method.bind(entry.evo).call(@@compair_against) }
    else
      Proc.new { |entry| @@compairson_method.bind(entry.evo).call }
    end
  end

  def push_local_to_class
    @@compairson_method = @compairson_method
    @@compair_against = @compair_against
  end

  private

  def int
    1
  end

  def find_proc_args
    if @ints.size == 1 && [1, 2, 3].union(@ints) == [1, 2, 3]
      @compairson_method = int.method(:==).unbind
      @compair_against = @ints.first
    elsif [1,2].permutation.include?(@ints)
      @compairson_method = int.method(:<).unbind
      @compair_against = 3
    elsif [2,3].permutation.include?(@ints)
      @compairson_method = int.method(:>).unbind
      @compair_against = 1
    elsif [1,3].permutation.include?(@ints)
      @compairson_method = int.method(:odd?).unbind
      @compair_against = false
    elsif @ints.empty?
      @no_exec = true
    else
      if @ints.include?(0)
        raise(BadEvoError, "While we encourage you to have eggs in your D&D night, you don't really need us to generate them (Do you?!?). tall_grass just helps you decide what goes in it, so don't ask us for stage 0 pokemon from now on.")
      else
        raise(BadEvoError, "This program only considers evolution stages 1-3. #{@ints} contains a number not within this range." )
      end
    end
  end

end

class BadEvoError < StandardError; end
