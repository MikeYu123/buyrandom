class AuctionsController < ApplicationController
  def index
    @auctions = Auction.active.includes(:product)
  end

  def show
    @auction = Auction.includes(:product).find(params[:id])
  end
end
