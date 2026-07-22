require "spec_helper"
require_relative "../lib/printer"
require_relative "../lib/models/item"

RSpec.describe Printer do
  it "prints each line, the total tax and the total" do
    receipt = {
      lines: [
        { item: Item.new(name: "book", quantity: 2, unit_price: 12.49), total: 27.48 }
      ],
      total_tax: 2.5,
      total: 27.48
    }

    expect { Printer.new(receipt).print }.to output(
      "2 book: 27.48\nSales Taxes: 2.50\nTotal: 27.48\n"
    ).to_stdout
  end
end
