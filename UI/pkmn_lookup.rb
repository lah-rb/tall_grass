require 'fileutils'
require_relative 'prompt.rb'
require_relative '../dex_shelf.rb'

class Lookup
  include Prompt
  public

  def initialize()
    FileUtils.cd('..')
    @dex_shelf = DexShelf.new
  end

  def run_lookup
    @dex_shelf.look_in_dex(name_or_num, get_pkmn)
  end

  private

  def name_or_num
    get_info('Look up by name or number? (name/#) ').downcase
  end

  def get_pkmn
    get_info('What are you searching for? ').capitalize
  end
end

Lookup.new.run_lookup
