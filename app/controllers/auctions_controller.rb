class AuctionsController < ApplicationController
  def index
    @auctions = Auction.active
  end
end
