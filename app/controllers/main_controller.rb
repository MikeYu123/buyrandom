class MainController < ApplicationController
	def index
		service = MainPageService.new
		@hot_auctions = service.fetch_hot_auctions
		@expiring_auctions = service.fetch_expiring_auctions
	end

	def landing
    if current_user
      return redirect_to :index
    end
  end
end
