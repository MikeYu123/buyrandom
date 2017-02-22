class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.string :picture_url
      t.string :source
      t.string :source_url
      t.decimal :price

      t.timestamps
    end
  end
end
