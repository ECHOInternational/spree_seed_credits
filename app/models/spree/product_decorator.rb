module Spree
  Product.class_eval do
    delegate :seed_credit_value, :seed_credit_value=, to: :master

    def has_seed_credit_value?
    	return false if seed_credit_value.nil?
    	if seed_credit_value > 0
    		return true
    	else
    		return false
    	end
    end
  end
end