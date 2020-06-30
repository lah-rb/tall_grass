require 'fileutils'
require_relative '../dex_shelf.rb'

class Lookup
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
    puts
    print 'Look up by name or number? (name/#) '
    $stdin.gets.downcase.chomp
  end

  def get_pkmn
    puts
    print 'What are you searching for? '
    $stdin.gets.capitalize.chomp
  end
end

Lookup.new.run_lookup
