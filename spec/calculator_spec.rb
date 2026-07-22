require "spec_helper"
require_relative "../lib/calculator"
require_relative "../lib/models/item"

RSpec.describe Calculator do
  it "applies a flat 10% sales tax, rounded up to the nearest nickel" do
    items = [Item.new(name: "music CD", quantity: 1, unit_price: 14.99, imported: false)]

    receipt = Calculator.new(items).receipt

    expect(receipt[:lines].first[:tax]).to eq(1.5)
    expect(receipt[:lines].first[:total]).to eq(16.49)
    expect(receipt[:total_tax]).to eq(1.5)
    expect(receipt[:total]).to eq(16.49)
  end

  # Exemptions are not implemented yet, so this 10% applies even to a book.
  it "multiplies tax and total by quantity" do
    items = [Item.new(name: "book", quantity: 2, unit_price: 12.49, imported: false)]

    receipt = Calculator.new(items).receipt

    expect(receipt[:lines].first[:tax]).to eq(2.5)
    expect(receipt[:lines].first[:total]).to eq(27.48)
  end
end
