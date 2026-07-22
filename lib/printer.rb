class Printer
  def initialize(receipt)
    @receipt = receipt
  end

  def print
    @receipt[:lines].each do |line|
      item = line[:item]
      puts "#{item.quantity} #{item.name}: #{format_money(line[:total])}"
    end

    puts "Sales Taxes: #{format_money(@receipt[:total_tax])}"
    puts "Total: #{format_money(@receipt[:total])}"
  end

  private

  def format_money(amount)
    format("%.2f", amount)
  end
end
