class Printer
  def initialize(receipt)
    @receipt = receipt
  end

  def print
    raise NotImplementedError
  end
end
