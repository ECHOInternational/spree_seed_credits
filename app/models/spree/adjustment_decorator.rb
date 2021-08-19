module Spree
  module AdjustmentDecorator
	Adjustment.class_eval do
		delegate :credit_count, to: :source
	end
  end
end
