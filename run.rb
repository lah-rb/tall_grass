require_relative 'dir_manager.rb'
require_relative 'prompt.rb'
Dir['frontend/*'].each { |script| require_relative script }

class Runner
  include Prompt

  def initialize
    run
  end

  def hire(object)
    sleep(2)
    run
  end

  def run
    @director = DirManager.new
    @director.request_dir('tall_grass')

    case get_info(prompt_mint(14)).chr.downcase
    when 'e'
      hire Encounter.new
    when 'n'
      hire Pioneer.new
    when 's'
      hire Save.new
    when 'r'
      hire Explorer.new
    when 'm'
      hire Coordinator.new
    when 'i'
      hire Librarian.new
    when ''
      exit
    else
      display "I don't recognize that input."
      run
    end
  end
end

Runner.new
