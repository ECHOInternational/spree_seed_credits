module Spree
  class SeedCredit < ApplicationRecord
    include Spree::AdjustmentSource
    belongs_to :order

    def add_adjustment line_item
      #create_unique_adjustment comes from the Spree::AdjustmentSource
      # create_unique_adjustment order, line_item
      return if already_adjusted? line_item
      amount = compute_amount(line_item)
      adjustments.new(order: order,
                      adjustable: line_item,
                      label: "Seed Credit",
                      amount: amount,
                      included: false).save
    end

    def label
      "Seed Credit"
    end

    def compute_amount target
      puts "-DEBUG--------------------"
      puts "Target ID: #{target.id}"
      item = target.variant
      amount = 0
      return amount if target.quantity < 1
      return amount unless item.has_seed_credit_value?
      puts "Seed Credit Value: #{item.seed_credit_value}"
      puts "Target.Quantity: #{target.quantity}"
      puts "Max Allowed: #{item.max_items_allowed_using_seed_credits}"

      # Which is smaller the quantity being requested or the max number allowed? Use the smaller amount.
      desired_multiplier = target.quantity < item.max_items_allowed_using_seed_credits ? target.quantity : item.max_items_allowed_using_seed_credits
      puts "Desired Multiplier: #{desired_multiplier}"
      
      # We need to reset any value this may have had before.
      # binding.pry
      prev_credit_count = target.seed_credits_used ? target.seed_credits_used :  0
      puts "Previous Credit Count: #{prev_credit_count}"
      greatest_possible_multiplier = ((order.seed_credit_count + prev_credit_count)/ item.seed_credit_value).floor
      # binding.pry
      puts "Greatest Possible Multiplier: #{greatest_possible_multiplier}"
      actual_multiplier = desired_multiplier < greatest_possible_multiplier ? desired_multiplier : greatest_possible_multiplier
      puts "Actual Multiplier: #{actual_multiplier}"

      puts "Credits to subtract: #{item.seed_credit_value * actual_multiplier}"
      update_attribute(:credit_count, (item.seed_credit_value * actual_multiplier))
      amount -= target.price * actual_multiplier
      puts "Amount to subtract: #{amount}"
      amount
    end
  end
end