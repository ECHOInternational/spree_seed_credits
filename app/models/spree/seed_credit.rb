module Spree
  class SeedCredit < ApplicationRecord
    include Spree::AdjustmentSource
    belongs_to :order
    before_create :load_credit_count

    def add_adjustment line_item
      #create_adjustment comes from the Spree::AdjustmentSource
      create_adjustment order, line_item
    end

    def label
      "Seed Credit"
    end

    def has_remaining_credits?
    	credit_count > 0
    end

    def has_adequate_remaining_credits? credits_needed
    	credit_count >= credits_needed
    end



    def compute_amount target
      amount = 0
      return amount unless has_remaining_credits?

      if target.variant.seed_credit_value && target.variant.seed_credit_value > 0
        target.quantity.times do |i|
          # Need to limit the quantity per line item that qualifies?
          #Don't give credit for more than 2
          # break if i > 1 
          if has_adequate_remaining_credits? target.variant.seed_credit_value
            amount -= target.price
            self.credit_count -= target.variant.seed_credit_value
          end
        end
        save
      end
      amount
    end

    private

    def load_credit_count
      self.credit_count = order.user.available_seed_credits
    end
  end
end