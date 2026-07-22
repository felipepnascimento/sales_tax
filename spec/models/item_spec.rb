require "spec_helper"
require_relative "../../lib/models/item"

RSpec.describe Item do
  it "builds a valid item" do
    item = Item.new(name: "book", quantity: 2, unit_price: 12.49, imported: false)

    expect(item.name).to eq("book")
    expect(item.quantity).to eq(2)
    expect(item.unit_price).to eq(12.49)
    expect(item.imported).to eq(false)
  end

  it "defaults imported to false" do
    item = Item.new(name: "book", quantity: 1, unit_price: 12.49)

    expect(item.imported).to eq(false)
  end

  it "raises when name is blank" do
    expect { Item.new(name: "", quantity: 1, unit_price: 1.0) }.to raise_error(ArgumentError)
  end

  it "raises when quantity is not greater than zero" do
    expect { Item.new(name: "book", quantity: 0, unit_price: 1.0) }.to raise_error(ArgumentError)
  end

  it "raises when unit_price is negative" do
    expect { Item.new(name: "book", quantity: 1, unit_price: -1.0) }.to raise_error(ArgumentError)
  end
end
