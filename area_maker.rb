require './dex.rb'
require './dex_maker.rb'

module AreaMaker
  include Dex
  include DexMaker

  def self.store
    './dex_store/'
  end

end
