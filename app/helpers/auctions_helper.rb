module AuctionsHelper
	def render_amounts auction
		current = number_to_currency auction.current_amount
		target = number_to_currency auction.target_amount
		"#{current} #{t('views.auction.of')} #{target}"
	end

	def render_time auction
		"#{distance_of_time_in_words(auction.expires_at - DateTime.now)} #{t 'views.auction.remaining'}"
	end

	def render_progress auction
	  progress_percentage = (100 * auction.current_amount) / auction.target_amount
    number_to_percentage(progress_percentage, precision: 0)
  end
end
