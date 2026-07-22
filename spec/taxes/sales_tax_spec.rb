require "spec_helper"
require_relative "../../lib/taxes/sales_tax"
require_relative "../../lib/models/item"

RSpec.describe SalesTax do
  it "charges 10% rounded up to the nearest nickel for non-exempt items" do
    item = Item.new(name: "music CD", quantity: 1, unit_price: 14.99, category: :other)

    expect(SalesTax.new.amount_for(item)).to eq(1.5)
  end

  it "multiplies by quantity" do
    item = Item.new(name: "gadget", quantity: 2, unit_price: 12.49, category: :other)

    expect(SalesTax.new.amount_for(item)).to eq(2.5)
  end

  it "is exempt for books, food and medical items" do
    [:book, :food, :medical].each do |category|
      item = Item.new(name: "item", quantity: 1, unit_price: 10.00, category: category)

      expect(SalesTax.new.amount_for(item)).to eq(0)
    end
  end
end
