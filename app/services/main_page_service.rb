class MainPageService
	# TODO config
	HOT_AUCTIONS_COUNT=4
	EXPIRING_AUCTIONS_COUNT=4

	def fetch_hot_auctions
		Auction.order(current_amount: :desc).limit(HOT_AUCTIONS_COUNT).includes(:product)
	end

	def fetch_expiring_auctions
		Auction.order(expires_at: :asc).limit(HOT_AUCTIONS_COUNT).includes(:product)
	end
end