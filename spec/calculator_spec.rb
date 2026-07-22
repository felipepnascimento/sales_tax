require "spec_helper"
require_relative "../lib/calculator"

RSpec.describe Calculator do
  it "raises until the architecture is defined" do
    calculator = Calculator.new("2 book at 12.49")
    expect { calculator.receipt }.to raise_error(NotImplementedError)
  end
end
