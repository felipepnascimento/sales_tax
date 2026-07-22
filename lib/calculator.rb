class Calculator
  def initialize(input)
    @input = input
  end

  def receipt
    raise NotImplementedError
  end
end
