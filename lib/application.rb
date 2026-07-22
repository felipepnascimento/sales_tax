require_relative "parser"
require_relative "calculator"
require_relative "printer"

class Application
  def initialize(input)
    @input = input
  end

  def run
    items = Parser.new(@input).parse
    receipt = Calculator.new(items).receipt
    Printer.new(receipt).print
  end
end
