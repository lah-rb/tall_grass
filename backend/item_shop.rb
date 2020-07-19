require_relative '../dir_manager.rb'
require_relative 'dex.rb'
require_relative 'dex_maker_toolbox.rb'
require_relative 'distributer.rb'

class ItemShop < Distributer
  include Dex
  include DexMakerToolbox

  def initialize
    @director = DirManager.new
    @director.request_dir('backend')
    @stock = Dex.compile_dex('./dex_store/items_dex', true)
  end

  def in_stock(need)
    case need
    when ''
      return @stock
    else
      return @stock.select { |item| item.last == need }
    end
  end

  def deal(offerings)
    @seed = random_seed(offerings)
    return offerings[@seed]
  end
end
