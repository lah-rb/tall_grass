require_relative '../prompt.rb'
require_relative '../backend/item_shop.rb'
require_relative '../managers_assistant.rb'

class ShopKeeper
  include Prompt
  include ManagersAssistant

  public

  Catalog = [
    "Held Item", "Key Item", "Berry", "Mail", "Medicine", "Fossil",
    "Miscellaneous Item", "Vitamin", "Pokeball", "Evolutionary Item",
    "Held Evolutionary Item", "Battle Item",
  ]
  Shop = ItemShop.new

  def checkout_good
    @good = best_deal(Shop.in_stock(section_from_catalog))
    show (
      'Here is your ' + @good[0].gsub('_', ' ') + ". The catalog description says "\
      + @good[1].gsub('_', ' ') + ' if you trust that kind of marketing.'
    )
  end

  def checkout_cart
    @num_of_items = get_info('How many items would you like in this cart?').to_i
    @supply = Shop.in_stock
    @cart = (1..@num_of_items).map do
      item = fill_cart(@supply)
      item[0].gsub('_', ' ') + ' - ' + item[1].gsub('_', ' ')
    end
    show_list(@cart, 'Here are your goods!')
  end

  private

  def section_from_catalog
    show_list(Catalog, 'Types of items we carry:')
    @section = get_info('What type of item do you need?', 'Hit return for any')
    @section_num = @section.to_i

    if not_in_range?(@section, Catalog)
      show "We don't carry that kind of item. Sorry."
      section_from_catalog
    elsif @section_num.to_s == @section
      return Catalog[@section.to_i - 1].gsub(' ', '_')
    else
      @section = @section.gsub(' ', '_').split('_').map(&:capitalize).join('_')
      if Catalog.include?(@section) || @section.empty?
        return @section
      else
        show "We don't carry that kind of item. Sorry."
        section_from_catalog
      end
    end
  end

  def fill_cart(offerings)
    @seed = rand(0...offerings.size)
    return offerings[@seed]
  end

  def best_deal(offerings)
    @seed = random_seed(offerings)
    return offerings[@seed]
  end
end
