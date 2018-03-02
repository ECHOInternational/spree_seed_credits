class AddSeedCreditsUsedToSpreeLineItems < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_line_items, :seed_credits_used, :integer
  end
end
