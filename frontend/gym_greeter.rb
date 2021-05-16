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
      comp = @hub.random_trainer
      show_list(
        comp.party.map { |pkmn| [pkmn[0].name, pkmn[1]] },
        prompt_mint(:comptrainer, comp.job, comp.name)
      )
  end
end
