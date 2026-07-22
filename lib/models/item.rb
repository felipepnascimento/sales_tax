class Item
  attr_reader :name, :quantity, :unit_price, :imported

  def initialize(name:, quantity:, unit_price:, imported: false)
    raise ArgumentError, "name can't be blank" if name.nil? || name.strip.empty?
    raise ArgumentError, "quantity must be greater than zero" unless quantity.to_i > 0
    raise ArgumentError, "unit_price must be greater than or equal to zero" unless unit_price.to_f >= 0

    @name = name
    @quantity = quantity
    @unit_price = unit_price
    @imported = imported
  end

  def ==(other)
    other.is_a?(Item) &&
      name == other.name &&
      quantity == other.quantity &&
      unit_price == other.unit_price &&
      imported == other.imported
  end
end
