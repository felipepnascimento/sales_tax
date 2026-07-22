require_relative "models/item"
require_relative "categorizer"

class Parser
  LINE_PATTERN = /\A(\d+)\s+(imported\s+)?(.+)\s+at\s+(\d+\.\d{2})\z/

  def initialize(input)
    @input = input
  end

  def parse
    @input.each_line.map do |line|
      match = LINE_PATTERN.match(line.strip)
      raise ArgumentError, "invalid input line: #{line}" unless match

      quantity, imported, name, unit_price = match.captures
      Item.new(
        name: name,
        quantity: quantity.to_i,
        unit_price: unit_price.to_f,
        imported: !!imported,
        category: Categorizer.categorize(name)
      )
    end
  end
end
