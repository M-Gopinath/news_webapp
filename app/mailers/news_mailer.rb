class NewsMailer < ApplicationMailer
	def send_news_link(link,email)
		@link = link
		@email = email
		mail(to: @email ,subject: "News Article")
	end
end
