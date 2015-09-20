module PlacesHelper
	
	def render_price(place)
		if price = place.price
			price_tag = ''
			price.times {price_tag = price_tag + '<i class="fa fa-usd dollar-sign"></i>'}
			('<div class="attributes"><strong>Price: </strong><p class="text-truncate">' + price_tag + '</p><div class="clear"></div></div>').html_safe
		end
	end
end
