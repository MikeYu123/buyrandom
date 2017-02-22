class Auction < ApplicationRecord
  belongs_to :product
  audited
end
