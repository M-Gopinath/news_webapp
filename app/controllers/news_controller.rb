class NewsController < ApplicationController
 
  def index
    @responses = NewsApiService.new({url: "recent"}).get_latest_new
    @articles = @responses['articles']
    render layout: "news_layout"
  end

  def get_article
  	@article = {url: params[:url], title: params[:title],author: params[:author],description: params[:desc],image: params[:img],publish_at: params[:publish_at],source: params[:source]}
  end

  def get_overall_articles
  	@responses = NewsApiService.new({url: params[:type]}).get_latest_new
  	@articles = @responses['articles']
  end

  def api_news_search
    @responses = NewsApiService.new({url: params[:type],search: params[:search]}).get_latest_new
    @articles = @responses['articles']
  end

  def email_for_api_link
    @link = params[:link]
    NewsMailer.send_news_link(params[:link],params[:email]).deliver
  end
end



