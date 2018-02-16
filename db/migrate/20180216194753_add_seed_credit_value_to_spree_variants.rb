class AddSeedCreditValueToSpreeVariants < SpreeExtension::Migration[5.1]
  def change
    add_column :spree_variants, :seed_credit_value, :integer
  end
end
