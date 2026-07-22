require_relative "nickel_rounding"

class ImportDuty
  include NickelRounding

  RATE = 0.05

  def amount_for(item)
    return 0 unless item.imported

    (round_up_to_nearest_nickel(item.unit_price * RATE) * item.quantity).round(2)
  end
end
