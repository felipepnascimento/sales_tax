require "spec_helper"
require_relative "../lib/parser"

RSpec.describe Parser do
  it "raises until the architecture is defined" do
    parser = Parser.new("2 book at 12.49")
    expect { parser.parse }.to raise_error(NotImplementedError)
  end
end
