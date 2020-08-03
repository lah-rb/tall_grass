require_relative '../dir_manager.rb'
require_relative 'dex.rb'
require_relative 'dex_maker_toolbox.rb'

class ItemShop
  include Dex
  include DexMakerToolbox

  def initialize
    @director = DirManager.new
    @director.request_dir('backend')
    @stock = Dex.compile_dex('./dex_store/items_dex', true)
  end

  def in_stock(need = '')
    case need
    when ''
      return @stock
    else
      return @stock.select { |item| item.last == need }
    end
  end
end
