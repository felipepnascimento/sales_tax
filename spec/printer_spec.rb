require "spec_helper"
require_relative "../lib/printer"

RSpec.describe Printer do
  it "raises until the architecture is defined" do
    printer = Printer.new(nil)
    expect { printer.print }.to raise_error(NotImplementedError)
  end
end
