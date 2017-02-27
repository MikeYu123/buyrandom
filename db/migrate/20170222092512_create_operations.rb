class CreateOperations < ActiveRecord::Migration[5.0]
  def change
    create_table :operations do |t|
      t.float :amount
      t.references :source, polymorphic: true
      t.references :destination, polymorphic: true

      t.timestamps
    end
  end
end
