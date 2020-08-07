require_relative '../dir_manager.rb'
require_relative '../prompt.rb'
require_relative '../backend/trainer.rb'
require_relative '../backend/trainer_hub.rb'

class GymGreeter
  include Prompt

  def initialize
    @director = DirManager.new
    @director.request_dir('backend')
    @hub = TrainerHub.new
  end

  def greet
    challenge_type = get_info(
      'Would you like to face a gym member or a random trainer?',
      'g or r'
    )
    case challenge_type.downcase.chr
    when 'g'
      display 'In the works!'
    when 'r'
      comp = @hub.random_trainer
      display "Alright! Your competition is #{comp.name} and here is their team!"
      puts comp.party
    else
      display 'What???'
      greet
    end
  end

end
