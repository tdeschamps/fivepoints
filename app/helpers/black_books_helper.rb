module BlackBooksHelper
	def facebook_black_book_url_render(resource)
		black_book_url(resource).gsub(/[\:\/]/,":" => "%3A", "/" => "%2F")
	end
end
