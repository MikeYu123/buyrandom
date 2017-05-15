class AuctionsController < ApplicationController
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper

  def index
    @auctions_scope = Auction.active.includes(:product)
    @auctions_scope = @auctions_scope.by_name(params[:filter_name]) if params[:filter_name]
    @auctions = smart_listing_create(:auctions, @auctions_scope, partial: "auctions/listing")
  end

  def show
    @auction = Auction.includes(:product).find(params[:id])
  end
end
