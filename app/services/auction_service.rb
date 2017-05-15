class AuctionService
	BUYRANDOM_COMMISSION = 1.25
	AUCTION_DURATION = 1.week

	def create_auction product
		Auction.create product: product,
			current_amount: 0,
			target_amount: product.price * BUYRANDOM_COMMISSION,
			started_at: DateTime.now,
			expires_at: DateTime.now + AUCTION_DURATION
	end

	def build_auction product
		Auction.new product: product,
									 current_amount: 0,
									 target_amount: product.price * BUYRANDOM_COMMISSION,
									 started_at: DateTime.now,
									 expires_at: DateTime.now + AUCTION_DURATION
	end
end