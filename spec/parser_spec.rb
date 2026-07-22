require "spec_helper"
require_relative "../lib/parser"

RSpec.describe Parser do
  it "parses a domestic item line" do
    items = Parser.new("2 book at 12.49").parse

    expect(items).to eq([Item.new(name: "book", quantity: 2, unit_price: 12.49, imported: false)])
  end

  it "parses an imported item line" do
    items = Parser.new("1 imported bottle of perfume at 47.50").parse

    expect(items).to eq([Item.new(name: "bottle of perfume", quantity: 1, unit_price: 47.50, imported: true)])
  end

  it "parses multiple lines" do
    input = "2 book at 12.49\n1 music CD at 14.99"

    items = Parser.new(input).parse

    expect(items).to eq([
      Item.new(name: "book", quantity: 2, unit_price: 12.49, imported: false),
      Item.new(name: "music CD", quantity: 1, unit_price: 14.99, imported: false)
    ])
  end
end
