class ReturnBidService
  def initialize bid
    @bid = bid
  end

  def call
    @bid.transaction do
      BidCancel.create(source: @bid.destination,
                       destination: @bid.source,
                       amount: @bid.amount,
                       parent: @bid)
      @bid.source.deposit(@bid.amount)
      @bid.destination.withdraw(@bid.amount)
    end
  end
end