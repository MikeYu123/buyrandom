class AddTypeToOperations < ActiveRecord::Migration[5.0]
  def change
    add_column :operations, :type, :string, index: true
  end
end
