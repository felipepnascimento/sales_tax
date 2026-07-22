class SalesTax
  RATE = 0.10
  EXEMPT_CATEGORIES = [:book, :food, :medical].freeze

  def amount_for(item)
    return 0 if EXEMPT_CATEGORIES.include?(item.category)

    round_up_to_nearest_nickel(item.unit_price * RATE) * item.quantity
  end

  private

  def round_up_to_nearest_nickel(amount)
    (amount / 0.05).ceil * 0.05
  end
end
