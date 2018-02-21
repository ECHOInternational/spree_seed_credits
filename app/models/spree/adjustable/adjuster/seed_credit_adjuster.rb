module Spree
  module Adjustable
    module Adjuster
      class SeedCreditAdjuster < Spree::Adjustable::Adjuster::Base
        def update
          # binding.pry
          @totals[:non_taxable_adjustment_total] += adjustments.where(source_type: "Spree::LineItem").reload.map(&:update!).compact.sum
          #binding.pry
        end
      end
    end
  end
end
