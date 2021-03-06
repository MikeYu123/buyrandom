class CreatePayments < ActiveRecord::Migration[5.0]
  def change
    create_table :payments do |t|
      t.string :sign
      t.boolean :confirmed
      t.belongs_to :user
      t.integer :amount

      t.timestamps
    end
  end
end
