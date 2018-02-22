module Spree
	Order.class_eval do
		has_one :seed_credit, dependent: :destroy
		delegate :credit_count, :credit_count=, to: :seed_credit, prefix: :seed
		before_create :build_seed_credit
	end
end