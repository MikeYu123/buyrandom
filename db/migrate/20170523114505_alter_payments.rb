class AlterPayments < ActiveRecord::Migration[5.0]
  def change
    rename_column :payments, :sign, :inplat_id
    add_index :payments, :inplat_id
  end
end
