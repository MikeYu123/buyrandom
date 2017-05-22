class AuctionsController < ApplicationController
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper

  before_action :authenticate_user!, only: [:new, :create, :bid]

  def index
    @auctions_scope = Auction.active.includes(:product)
    @auctions_scope = @auctions_scope.by_name(params[:filter_name]) if params[:filter_name]
    @auctions = smart_listing_create(:auctions, @auctions_scope, partial: "auctions/listing")
  end

  def show
    @auction = Auction.includes(:product, operations: :source).find(params[:id])
  end

  def new
    @product = Product.find(params[:product_id])
    @auction = AuctionService.new.build_auction(@product)
  end

  def create
    @product = Product.find(params[:auction][:product_id])
    @auction = AuctionService.new.create_auction(@product)
    @auction.update(user: current_user)
    redirect_to auction_path(@auction)
  end

  def bid
    amount = params[:amount].to_f
    @auction = Auction.find(params[:auction_id])
    @transaction_result = PlaceBidService.new(amount: amount, user: current_user, auction: @auction).call
  rescue PlaceBidService::InactiveAuctionError
    @auction.errors[:base] << t('auctions.form.errors.inactive_auction')
  rescue PlaceBidService::InsufficientFundsError
    @auction.errors[:base] << t('auctions.form.errors.insufficient_funds')
  rescue PlaceBidService::IncorrectAmountError
    @auction.errors[:base] << t('auctions.form.errors.incorrect_amount')
  ensure
    render 'auctions/show'
  end
end
