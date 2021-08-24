class CreateSpreeSeedCredits < SpreeExtension::Migration[5.1]
  def change
    create_table :spree_seed_credits do |t|
      t.integer :credit_count
      t.references :spree_order, foreign_key: true

      t.timestamps
    end
  end
end
