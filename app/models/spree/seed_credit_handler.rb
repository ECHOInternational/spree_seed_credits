module Spree
	class SeedCreditHandler

		attr_reader :line_item, :order

		def initialize(order, line_item = nil)
			@order = order
			@line_item = line_item
		end

		def activate
			if line_item
				new_adjustment = line_item.adjustments.create
				new_adjustment.label = "Seed Credit Adjustment"
				new_adjustment.order = @order
				new_adjustment.source = line_item
				new_adjustment.amount = compute_amount line_item
				# binding.pry
				new_adjustment.save!
			end
		end

		def compute_amount target
			(target.pre_tax_amount * -1)
		end

		private

		def line_item_has_seed_credit_value?
			@line_item.product.try(:seed_credit_value) > 0
		end

	end
end