class Auction < ApplicationRecord
  belongs_to :product
  audited

  delegate :picture_url, :name, :description, to: :product

  scope :active, -> { where('expires_at >= ?', DateTime.now)}
  scope :by_name, ->(name) { joins(:product).where('products.name LIKE ?', "%#{name}%") }
end
