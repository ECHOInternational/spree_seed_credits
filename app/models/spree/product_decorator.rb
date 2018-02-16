module Spree
  Product.class_eval do
    delegate :seed_credit_value, :seed_credit_value=, to: :master
  end
end