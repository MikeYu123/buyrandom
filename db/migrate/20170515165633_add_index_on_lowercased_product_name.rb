class AddIndexOnLowercasedProductName < ActiveRecord::Migration[5.0]
  def up
    execute 'CREATE INDEX index_products_on_lowercase_name
             ON products (lower(name));'
  end

  def down
    execute 'DROP INDEX index_products_on_lowercase_name;'
  end
end
