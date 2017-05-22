class Auction < ApplicationRecord
  belongs_to :product
  belongs_to :user
  audited

  delegate :picture_url, :name, :description, to: :product
  has_many :bids, as: :destination

  def active?
    now = DateTime.now
    expires_at > now && started_at < now
  end

  def widthraw amount
    raise ArgumentError if current_amount < amount || amount < 0
    update(current_amount: current_amount - amount)
  end

  def deposit amount
    raise ArgumentError if amount < 0
    update(current_amount: current_amount + amount)
  end

  def remaining_amount
    target_amount - current_amount
  end

  def minimal_bid
    target_amount > 2500 ? 250 : target_amount * 0.1
  end

  scope :active, -> { where('expires_at >= ?', DateTime.now)}
  scope :by_name, ->(name) { joins(:product).where('lower(products.name) LIKE ?', "%#{name.downcase}%") }
end
