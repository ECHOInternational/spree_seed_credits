module Spree
	Adjustment.class_eval do
		delegate :credit_count, to: :source
	end
end