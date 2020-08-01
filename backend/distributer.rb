require 'open-uri'
require_relative '../prompt.rb'

class Distributer
  include Prompt

  def random_seed(dex)
    unless dex.empty?
      begin
        @seed = URI.open(prompt_mint(randomurl, dex.size)).string.chomp.to_i - 1
      rescue
        @seed = rand(1..dex.size) - 1
      end
    end
  end
end
