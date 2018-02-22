# This is currently unused, we might integrate it later, but it seems unnecessary
module Spree
  class Calculator::SeedCreditCalculator < Spree::Calculator
    def self.description
      "Sets price of items with applied seed credits to 0."
    end


    def compute(item)
      # item.amount
      0
    end
  end
end