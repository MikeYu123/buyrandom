class FinishAuctionService
  def initialize auction
    @auction = auction
  end

  def call
    if @auction.succeeded?
      seed = winning_seed
      bids_stack = create_bids_stack
      winner_id = determine_winner_id bids_stack, seed
      @auction.update(
        finished: true,
        winner_id: winner_id,
      )
      AuctionWinningNotification.create(user: winner_id, source: @auction)
    else
      @auction.bids.active.each { |bid| ReturnBidService.new(bid).call }
      @auction.update(
        finished: true,
      )
    end
  end

  def winning_seed
    rand * @auction.amount
  end

  def create_bids_stack
    @auction.bids.active.order(created_at: :asc).pluck(:amount, :id)
  end

  def determine_winner_id(bids_stack, seed)
    bids = bids_stack.clone
    sum = 0
    loop do
      bid = bids.shift
      sum += bid[0]
      break bid[1] if sum >=seed
    end
  end
end