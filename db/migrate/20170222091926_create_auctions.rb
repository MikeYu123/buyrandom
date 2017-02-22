class CreateAuctions < ActiveRecord::Migration[5.0]
  def change
    create_table :auctions do |t|
      t.references :product, foreign_key: true
      t.decimal :current_amount
      t.timestamp :expires_at
      t.timestamp :started_at
      t.decimal :target_amount

      t.timestamps
    end
  end
end
