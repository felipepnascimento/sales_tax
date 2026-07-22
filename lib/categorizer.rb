class Categorizer
  BOOK_KEYWORDS = ["book"].freeze
  FOOD_KEYWORDS = ["chocolate"].freeze
  MEDICAL_KEYWORDS = ["pill", "pills"].freeze

  def self.categorize(name)
    downcased = name.downcase

    return :book if BOOK_KEYWORDS.any? { |keyword| downcased.include?(keyword) }
    return :medical if MEDICAL_KEYWORDS.any? { |keyword| downcased.include?(keyword) }
    return :food if FOOD_KEYWORDS.any? { |keyword| downcased.include?(keyword) }

    :other
  end
end
