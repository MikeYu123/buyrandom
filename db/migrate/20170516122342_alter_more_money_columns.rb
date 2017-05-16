class AlterMoreMoneyColumns < ActiveRecord::Migration[5.0]
  def change
    change_column :auctions, :target_amount, :decimal, default: 0.0
    change_column :auctions, :current_amount, :decimal, default: 0.0
  end
end
