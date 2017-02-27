class Auction < ApplicationRecord
  belongs_to :product
  audited

  scope :active, -> { where('expires_at >= ?', DateTime.now)}
end
