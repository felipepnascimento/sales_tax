require "spec_helper"
require_relative "../lib/calculator"

RSpec.describe Calculator do
  it "raises until the architecture is defined" do
    calculator = Calculator.new([])
    expect { calculator.receipt }.to raise_error(NotImplementedError)
  end
end
