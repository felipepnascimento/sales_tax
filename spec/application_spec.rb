require "spec_helper"
require_relative "../lib/application"

RSpec.describe Application do
  it "wires Parser, Calculator and Printer together" do
    input = "2 book at 12.49"
    items = double("items")
    receipt = double("receipt")

    parser = instance_double(Parser, parse: items)
    calculator = instance_double(Calculator, receipt: receipt)
    printer = instance_double(Printer, print: nil)

    allow(Parser).to receive(:new).with(input).and_return(parser)
    allow(Calculator).to receive(:new).with(items).and_return(calculator)
    allow(Printer).to receive(:new).with(receipt).and_return(printer)

    Application.new(input).run

    expect(parser).to have_received(:parse)
    expect(calculator).to have_received(:receipt)
    expect(printer).to have_received(:print)
  end
end
