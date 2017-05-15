class Auction < ApplicationRecord
  belongs_to :product
  belongs_to :user
  audited

  delegate :picture_url, :name, :description, to: :product

  scope :active, -> { where('expires_at >= ?', DateTime.now)}
  scope :by_name, ->(name) { joins(:product).where('lower(products.name) LIKE ?', "%#{name.downcase}%") }
end
