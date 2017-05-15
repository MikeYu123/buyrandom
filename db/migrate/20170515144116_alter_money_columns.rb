class AlterMoneyColumns < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :balance, :decimal, default: 0.0
    change_column :operations, :amount, :decimal
  end
end
