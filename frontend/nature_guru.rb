require_relative '../prompt.rb'
require_relative '../backend/natures.rb'

class NatureGuru
  include Prompt

  def ask_guru
    sought_nature = Natures.new.lookup(
      get_info('Which nature do you seek to better understand?')
    )
    if sought_nature.empty?
      show "I am sorry, but the nature you speak of does not exist."
      ask_guru
    else
      show prompt_mint(:gurusadvice, *sought_nature)
    end
  end
end
