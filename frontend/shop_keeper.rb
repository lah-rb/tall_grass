require_relative '../prompt.rb'
require_relative '../backend/item_shop.rb'

class ShopKeeper
  include Prompt

  def initialize
     @shop = ItemShop.new
     @catalog = [
       "Held Item", "Key Item", "Berry", "Mail", "Medicine", "Fossil",
       "Miscellaneous Item", "Vitamin", "Pokeball", "Evolutionary Item",
       "Held Evolutionary Item", "Battle Item"
     ]
     customer_service
     offer_good
  end

  def customer_service
    display_list(@catalog, 'Types of items we carry:')
    @category = @catalog[
      get_info('What type of item do you need? (return for any) ').to_i - 1
    ]
    @goods_in_stock = @shop.in_stock(@category.gsub(' ', '_'))
  end

  def offer_good
    @good = @shop.deal(@goods_in_stock)
    display (
      'Here is your ' + @good[0].gsub('_', ' ') + ' which is a '\
      + @good[1].gsub('_', ' ')
    )
  end
end
