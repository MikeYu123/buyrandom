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

	def bidder_name operation
		operation.source.username || operation.source.email
	end

	def inplat_link
		'https://demo-v-jet.inplat.ru/?apikey=AmGisIKyumi8S7c8xg2tZp1C&theme=blue&title=&account=test&sum=100&sign=ea9149ca4d75f970ab8c346b3687f93a16b76dad3d4d289313ccee665a3e602c'
	end
end
