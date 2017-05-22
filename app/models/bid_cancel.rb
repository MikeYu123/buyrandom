class BidCancel < Operation
  belongs_to :parent, class_name: 'Bid'
end