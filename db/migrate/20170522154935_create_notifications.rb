class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.string :type, index: true
      t.belongs_to :user, foreign_key: true
      t.belongs_to :source, polymorphic: true
      t.boolean :notified, default: false

      t.timestamps
    end
  end
end
