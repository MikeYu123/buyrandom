class MainController < ApplicationController
	def index
		service = MainPageService.new
		@hot_auctions = service.fetch_hot_auctions
		@expiring_auctions = service.fetch_expiring_auctions
	end
end
