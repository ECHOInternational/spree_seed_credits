class AddMaxItemsAllowedPerOrderToSpreeVariants < SpreeExtension::Migration[5.1]
  def change
    add_column :spree_variants, :max_items_allowed_per_order, :int, default: 2
  end
end
