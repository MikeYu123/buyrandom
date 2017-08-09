module AuctionsHelper
	def render_amounts auction
		current = number_to_currency auction.current_amount
		target = number_to_currency auction.target_amount
		"#{current} #{t('views.auction.of')} #{target}"
	end

	def render_time auction
		"#{distance_of_time_in_words(auction.expires_at - DateTime.now)} #{t 'views.auction.remaining'}"
	end

	def render_money_progress auction
	  progress_percentage = (100 * auction.current_amount) / auction.target_amount
    number_to_percentage(progress_percentage, precision: 0)
	end

	def render_time_progress auction
		progress = DateTime.now.to_i - auction.started_at.to_i
		overall = auction.expires_at.to_i - auction.started_at.to_i
		progress_percentage = (100 * progress) / overall
		number_to_percentage(progress_percentage, precision: 0)
	end

	def result(auction)
		# TODO: is error_message correct for losing situation?
		if current_user.id == auction.winner_id
			content_tag(:p, t('auctions.results.you_won'), class: 'green-text')
		else
			content_tag(:p, t('auctions.results.you_lost'), class: %w(red-text text-accent-4))
		end

	end

	def bidder_name operation
		operation.source.username || operation.source.email
	end

	def inplat_link
		''
	end
end
