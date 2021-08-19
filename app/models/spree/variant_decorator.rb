module Spree
  module VariantDecorator
    Variant.class_eval do
      def has_seed_credit_value?
        return false if seed_credit_value.nil?
        seed_credit_value > 0
      end

      def items_limited_per_order?
          return false if max_items_allowed_per_order.nil?
          max_items_allowed_per_order > 0
      end

      def has_seed_credit_limit?
          return false unless has_seed_credit_value?
          return false if max_items_allowed_using_seed_credits.nil?
          max_items_allowed_using_seed_credits > 0
      end
    end
  end
end
