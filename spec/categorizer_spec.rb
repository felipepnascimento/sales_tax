require "spec_helper"
require_relative "../lib/categorizer"

RSpec.describe Categorizer do
  it "categorizes books" do
    expect(Categorizer.categorize("book")).to eq(:book)
  end

  it "categorizes chocolate as food" do
    expect(Categorizer.categorize("box of chocolates")).to eq(:food)
    expect(Categorizer.categorize("chocolate bar")).to eq(:food)
  end

  it "categorizes pills as medical" do
    expect(Categorizer.categorize("packet of headache pills")).to eq(:medical)
  end

  it "defaults to other" do
    expect(Categorizer.categorize("music CD")).to eq(:other)
    expect(Categorizer.categorize("bottle of perfume")).to eq(:other)
  end
end
