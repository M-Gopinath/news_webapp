Rails.application.routes.draw do
  get 'home/index'
  devise_for :admins, controllers: {
        sessions: 'admins/sessions', passwords: 'admins/passwords',registrations: 'admins/registrations', confirmations: 'admins/confirmations'
      }
  get 'news' => 'news#index'
  post 'get_article' => 'news#get_article'
  post 'get_overall_articles' => 'news#get_overall_articles'
  post 'api_news_search' => 'news#api_news_search'
  post 'email_for_api_link' => 'news#email_for_api_link'
  root 'news#index'
  namespace :admins do 
  	get 'dashboard' => 'dashboard#index'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
