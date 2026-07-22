SALES_TAX_RATE = 0.10

class Calculator
  def initialize(items)
    @items = items
  end

  def receipt
    lines = @items.map { |item| apply_tax_to(item) }

    {
      lines: lines,
      total_tax: lines.sum { |line| line[:tax] },
      total: lines.sum { |line| line[:total] }
    }
  end

  private

  def apply_tax_to(item)
    tax = round_up_to_nearest_nickel(item.unit_price * SALES_TAX_RATE)

    {
      item: item,
      tax: (tax * item.quantity).round(2),
      total: ((item.unit_price + tax) * item.quantity).round(2)
    }
  end

  def round_up_to_nearest_nickel(amount)
    (amount / 0.05).ceil * 0.05
  end
end
