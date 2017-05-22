class AddFinishedAndWinnerToAuctions < ActiveRecord::Migration[5.0]
  def change
    add_column :auctions, :finished, :boolean, default: false
    add_reference :auctions, :winner, foreign_key: {to_table: :users}
  end
end
