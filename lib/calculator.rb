require_relative "taxes/sales_tax"
require_relative "taxes/import_duty"

class Calculator
  def initialize(items, taxes: [SalesTax.new, ImportDuty.new])
    @items = items
    @taxes = taxes
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
    tax = @taxes.sum { |tax_rule| tax_rule.amount_for(item) }.round(2)

    {
      item: item,
      tax: tax,
      total: (item.unit_price * item.quantity + tax).round(2)
    }
  end
end
