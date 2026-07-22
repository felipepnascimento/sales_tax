require "spec_helper"
require_relative "../../lib/application"

RSpec.describe "Application (end-to-end)" do
  INPUTS_DIR = File.expand_path("../../inputs", __dir__)

  it "prints the exact receipt for input_1" do
    input = File.read(File.join(INPUTS_DIR, "input_1.txt"))

    expected = <<~RECEIPT
      2 book: 24.98
      1 music CD: 16.49
      1 chocolate bar: 0.85
      Sales Taxes: 1.50
      Total: 42.32
    RECEIPT

    expect { Application.new(input).run }.to output(expected).to_stdout
  end

  it "prints the exact receipt for input_2" do
    input = File.read(File.join(INPUTS_DIR, "input_2.txt"))

    expected = <<~RECEIPT
      1 imported box of chocolates: 10.50
      1 imported bottle of perfume: 54.65
      Sales Taxes: 7.65
      Total: 65.15
    RECEIPT

    expect { Application.new(input).run }.to output(expected).to_stdout
  end

  it "prints the exact receipt for input_3" do
    input = File.read(File.join(INPUTS_DIR, "input_3.txt"))

    expected = <<~RECEIPT
      1 imported bottle of perfume: 32.19
      1 bottle of perfume: 20.89
      1 packet of headache pills: 9.75
      3 imported boxes of chocolates: 35.55
      Sales Taxes: 7.90
      Total: 98.38
    RECEIPT

    expect { Application.new(input).run }.to output(expected).to_stdout
  end
end
