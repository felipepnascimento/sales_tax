class Calculator
  def initialize(items)
    @items = items
  end

  def receipt
    raise NotImplementedError
  end
end
