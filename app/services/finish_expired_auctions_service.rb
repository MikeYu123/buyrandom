class FinishExpiredAuctionsService
  def initialize
    @expired_auctions = Auction.inactive.unfinished
  end

  def call
    @expired_auctions.each do |auction|
      FinishAuctionService.new(auction).call
    end
  end

  def self.call
    new.call
  end
end