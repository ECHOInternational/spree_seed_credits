module Spree
  module OrderDecorator
	Order.class_eval do
		has_one :seed_credit, dependent: :destroy
		# delegate :credit_count, :credit_count=, to: :seed_credit, prefix: :seed
		before_create :build_seed_credit

		def seed_credits_used
			# the seed_credits_used is written to by the seed_credit_adjuster by populating the @totals[:seed_credits_used]
			line_items.sum(:seed_credits_used)
		end
		def seed_credit_count
			user.available_seed_credits - seed_credits_used
		end
		def has_remaining_credits?
			seed_credit_count > 0
		end
	    def has_adequate_remaining_credits? credits_needed
	    	seed_credit_count >= credits_needed
	    end
	end
  end
end
