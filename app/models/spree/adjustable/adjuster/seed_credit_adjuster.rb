module Spree
  module Adjustable
    module Adjuster
      class SeedCreditAdjuster < Spree::Adjustable::Adjuster::Base
        def update
          byebug
          @totals[:non_taxable_adjustment_total] += adjustments.where(source_type: "Spree::SeedCredit").reload.map(&:update!).compact.sum
          unless @adjustable.class == Spree::Shipment
            @totals[:seed_credits_used] = adjustments.where(source_type: "Spree::SeedCredit").sum(&:credit_count)
          end
        end
      end
    end
  end
end
