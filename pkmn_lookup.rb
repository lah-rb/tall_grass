require './dex.rb'

class Lookup
  include Dex

  def search_how
    print 'Look up by name or number? (name/#) '
    STDIN.gets.downcase.chomp
  end

  def get_criteria
    print 'What are you searching for? '
    STDIN.gets.capitalize.chomp
  end

  def make_output(num, name, evo, type_1, type_2)
    @info_string =
    "No. #{num} is \
    #{name} which is at evolution stage \
    #{evo} and is typed as \
    #{type_1}#{"-" + type_2 if type_2 != '%'}."
    return @info_string.split("  ").join
  end

  def look_in_dex(dex, search_means, what)
    case search_means
    when 'name'
      begin
        @pkmn = dex.select do |p|
                  if p[1][-1].match?(/["^"|!|#]/)
                     p[1].chop == what
                   else
                     p[1] == what
                   end
                 end
       @pkmn = @pkmn.flatten
        puts make_output(@pkmn[0], @pkmn[1], @pkmn[2], @pkmn[3], @pkmn[4])
      rescue
        puts "That name does not exist. Please check for spelling."
        exit
      end
    when '#', 'num', 'number'
      begin
        @seek = what.to_i - 1
        puts make_output(dex[@seek][0], dex[@seek][1],
        dex[@seek][2], dex[@seek][3], dex[@seek][4])
      rescue
        puts "That number appears to be out of the range of this pokedex."
      end
    end
  end

  def run_lookup
    @dex = Dex::pokedex
    @lookup_by = search_how
    @lookup_what = get_criteria
    look_in_dex(@dex, @lookup_by, @lookup_what)
  end

end

Lookup.new.run_lookup
