module Spree
  module ProductDecorator
    Product.class_eval do
      delegate :seed_credit_value, :seed_credit_value=, to: :master
      delegate :max_items_allowed_per_order, :max_items_allowed_per_order=, to: :master
      delegate :max_items_allowed_using_seed_credits, :max_items_allowed_using_seed_credits=, to: :master
      delegate :has_seed_credit_value?, :items_limited_per_order?, :has_seed_credit_limit?, to: :master
    end
  end
end
