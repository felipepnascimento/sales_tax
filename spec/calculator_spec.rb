require "spec_helper"
require_relative "../lib/calculator"
require_relative "../lib/models/item"

RSpec.describe Calculator do
  it "applies a flat 10% sales tax, rounded up to the nearest nickel" do
    items = [Item.new(name: "music CD", quantity: 1, unit_price: 14.99, category: :other)]

    receipt = Calculator.new(items).receipt

    expect(receipt[:lines].first[:tax]).to eq(1.5)
    expect(receipt[:lines].first[:total]).to eq(16.49)
    expect(receipt[:total_tax]).to eq(1.5)
    expect(receipt[:total]).to eq(16.49)
  end

  it "multiplies tax and total by quantity" do
    items = [Item.new(name: "gadget", quantity: 2, unit_price: 12.49, category: :other)]

    receipt = Calculator.new(items).receipt

    expect(receipt[:lines].first[:tax]).to eq(2.5)
    expect(receipt[:lines].first[:total]).to eq(27.48)
  end

  it "does not apply sales tax to exempt categories" do
    items = [Item.new(name: "book", quantity: 2, unit_price: 12.49, category: :book)]

    receipt = Calculator.new(items).receipt

    expect(receipt[:lines].first[:tax]).to eq(0)
    expect(receipt[:lines].first[:total]).to eq(24.98)
  end

  it "combines sales tax and import duty for imported items" do
    items = [Item.new(name: "bottle of perfume", quantity: 1, unit_price: 47.50, imported: true, category: :other)]

    receipt = Calculator.new(items).receipt

    expect(receipt[:lines].first[:tax]).to eq(7.15)
    expect(receipt[:lines].first[:total]).to eq(54.65)
  end

  it "applies import duty even to exempt categories" do
    items = [Item.new(name: "box of chocolates", quantity: 1, unit_price: 10.00, imported: true, category: :food)]

    receipt = Calculator.new(items).receipt

    expect(receipt[:lines].first[:tax]).to eq(0.50)
    expect(receipt[:lines].first[:total]).to eq(10.50)
  end
end
