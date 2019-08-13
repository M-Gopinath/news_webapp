class NewsApiService
	def initialize(params)
		@new_api = Admin::NEW_API
  	@url = URI(select_url(params[:url],params[:search]))
	end

	def get_latest_new
		http = Net::HTTP.new(@url.host, @url.port)
		http.use_ssl = true
		http.verify_mode = OpenSSL::SSL::VERIFY_NONE
		request = Net::HTTP::Get.new(@url)
		response = http.request(request)
		return JSON.parse(response.read_body)
	end

	def select_url(url,search=nil)
		case url
		when "country"
			"https://newsapi.org/v2/top-headlines?country=us&apiKey=#{@new_api}"
		when "sources"
			"https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=#{@new_api}"
		when "search"
			"https://newsapi.org/v2/top-headlines?q=#{search}&apiKey=#{@new_api}"
		when "recent"
			"https://newsapi.org/v2/top-headlines?sources=bloomberg,business-insider,buzzfeed,crypto-coins-news,engadget,entertainment-weekly,fortune&q=#{search}&apiKey=#{@new_api}"
		when "all"
			"https://newsapi.org/v2/everything?sources=bloomberg,business-insider,buzzfeed,crypto-coins-news,engadget,entertainment-weekly,fortune,google-news,hacker-news,mashable,newsweek,recode,tech%20crunch,techradar,wired&q=#{search}&apiKey=#{@new_api}"
		else
			"https://newsapi.org/v2/top-headlines?country=us&apiKey=#{@new_api}"
		end
	end
end