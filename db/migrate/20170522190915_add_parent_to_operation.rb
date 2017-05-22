class AddParentToOperation < ActiveRecord::Migration[5.0]
  def change
    add_reference :operations, :parent, foreign_key: {to_table: :operations}
  end
end
