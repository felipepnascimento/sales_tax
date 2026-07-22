module NickelRounding
  def round_up_to_nearest_nickel(amount)
    (amount / 0.05).ceil * 0.05
  end
end
