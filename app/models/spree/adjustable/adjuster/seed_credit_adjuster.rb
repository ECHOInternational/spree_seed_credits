module Spree
  module Adjustable
    module Adjuster
      class SeedCreditAdjuster < Spree::Adjustable::Adjuster::Base
        def update
        	# This doesn't seem very efficient
	    	@adjustable.order.seed_credit_count = @adjustable.order.user.available_seed_credits
	    	@adjustable.order.seed_credit.save

          @totals[:non_taxable_adjustment_total] += adjustments.where(source_type: "Spree::SeedCredit").reload.map(&:update!).compact.sum
        end
      end
    end
  end
end
