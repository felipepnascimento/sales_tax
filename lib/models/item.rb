class Item
  CATEGORIES = [:book, :food, :medical, :other].freeze

  attr_reader :name, :quantity, :unit_price, :imported, :category

  def initialize(name:, quantity:, unit_price:, imported: false, category: :other)
    raise ArgumentError, "name can't be blank" if name.nil? || name.strip.empty?
    raise ArgumentError, "quantity must be greater than zero" unless quantity.to_i > 0
    raise ArgumentError, "unit_price must be greater than or equal to zero" unless unit_price.to_f >= 0
    raise ArgumentError, "invalid category: #{category}" unless CATEGORIES.include?(category)

    @name = name
    @quantity = quantity
    @unit_price = unit_price
    @imported = imported
    @category = category
  end

  def ==(other)
    other.is_a?(Item) &&
      name == other.name &&
      quantity == other.quantity &&
      unit_price == other.unit_price &&
      imported == other.imported &&
      category == other.category
  end
end
