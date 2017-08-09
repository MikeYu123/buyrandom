class Bid < Operation
  has_one :bid_cancel, foreign_key: :parent_id
  belongs_to :source, polymorphic: true
  scope :active, -> {where(bid_cancel: nil)}
end