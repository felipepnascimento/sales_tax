require_relative "../utils/nickel_rounding"

class SalesTax
  include NickelRounding

  RATE = 0.10
  EXEMPT_CATEGORIES = [:book, :food, :medical].freeze

  def amount_for(item)
    return 0 if EXEMPT_CATEGORIES.include?(item.category)

    (round_up_to_nearest_nickel(item.unit_price * RATE) * item.quantity).round(2)
  end
end
