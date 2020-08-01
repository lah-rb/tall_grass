require_relative '../prompt.rb'
require_relative '../backend/item_shop.rb'

class ShopKeeper
  include Prompt
  Catalog = [
    "Held Item", "Key Item", "Berry", "Mail", "Medicine", "Fossil",
    "Miscellaneous Item", "Vitamin", "Pokeball", "Evolutionary Item",
    "Held Evolutionary Item", "Battle Item"
  ]

  def customer_service
     @shop = ItemShop.new
     offer_assistance
     offer_good
  end

  def offer_assistance
    display_list(Catalog, 'Types of items we carry:')
    @category = get_info('What type of item do you need?', 'Hit return for any')
    case @category.to_i
    when 0
      @category = @category.gsub(' ', '_').split('_').map(&:capitalize).join('_')
    else
      begin
        @category = Catalog[@category.to_i - 1].gsub(' ', '_')
      rescue NoMethodError
        display "We don't carry that kind of item. Sorry."
        raise SoftExit
      end
    end
    @goods_in_stock = @shop.in_stock(@category)
  end

  def offer_good
    begin
      @good = @shop.deal(@goods_in_stock)
    rescue TypeError
      display "We don't carry that kind of item. Sorry."
      raise SoftExit
    end
    display (
      'Here is your ' + @good[0].gsub('_', ' ') + ". The catalog description says "\
      + @good[1].gsub('_', ' ') + ' if you trust that kind of marketing.'
    )
  end
end

class SoftExit < StandardError; end
