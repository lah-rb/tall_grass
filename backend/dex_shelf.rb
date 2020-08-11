require_relative '../dir_manager.rb'
require_relative '../managers_assistant.rb'
require_relative '../prompt.rb'
require_relative 'dex.rb'

class DexShelf
  include Prompt
  include ManagersAssistant
  include Dex

  public

  def initialize
    @director = DirManager.new
    @director.request_dir('backend')
    @dex = Dex.pokedex
  end

  def look_in_dex(seek)
    @seek_num = seek.to_i
    @pkmn = @dex.find do |poke|
      if poke.name.match?(/["^"|!|#|*|~]/)
       poke.name.chop == seek
      else
       poke.name == seek
      end
    end

    if not_in_range?(seek, @dex)
      show "That number appears to be out of the range of this pokedex."
      return false
    elsif @seek_num.to_s == seek
      return @dex.find { |poke| poke.num == seek.to_i }
    elsif @pkmn
      return @pkmn
    else
      show "That name does not exist. Please check for spelling."
      return false
    end
  end
end
