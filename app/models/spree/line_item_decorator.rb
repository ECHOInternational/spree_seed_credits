module Spree
  LineItem.class_eval do
  	def compute_amount target
		(target.pre_tax_amount * -1)
  	end
  end
end
