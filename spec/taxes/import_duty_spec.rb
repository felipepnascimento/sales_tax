require "spec_helper"
require_relative "../../lib/taxes/import_duty"
require_relative "../../lib/models/item"

RSpec.describe ImportDuty do
  it "charges 5% rounded up to the nearest nickel for imported items" do
    item = Item.new(name: "bottle of perfume", quantity: 1, unit_price: 47.50, imported: true)

    expect(ImportDuty.new.amount_for(item)).to eq(2.40)
  end

  it "does not apply to domestic items" do
    item = Item.new(name: "bottle of perfume", quantity: 1, unit_price: 47.50, imported: false)

    expect(ImportDuty.new.amount_for(item)).to eq(0)
  end

  it "applies regardless of category" do
    item = Item.new(name: "box of chocolates", quantity: 1, unit_price: 10.00, imported: true, category: :food)

    expect(ImportDuty.new.amount_for(item)).to eq(0.50)
  end
end
