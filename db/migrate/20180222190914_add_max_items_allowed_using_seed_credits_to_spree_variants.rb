class AddMaxItemsAllowedUsingSeedCreditsToSpreeVariants < SpreeExtension::Migration[5.1]
  def change
    add_column :spree_variants, :max_items_allowed_using_seed_credits, :int, default: 2
  end
end
