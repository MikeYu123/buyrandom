class CreateOperations < ActiveRecord::Migration[5.0]
  def change
    create_table :operations do |t|
      t.float :amount
      t.references :source, foreign_key: true
      t.references :destination, foreign_key: true

      t.timestamps
    end
  end
end
