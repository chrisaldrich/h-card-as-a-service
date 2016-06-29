Rails.application.routes.draw do
  get 'nicknames/index'

  get 'nicknames/show'

  root 'about#home'

  get '/(:subdomain.):domain.:tld',      to: 'people#show'
  get '/(:subdomain.):domain.:tld/edit', to: 'people#edit'
  get '/new',                     to: 'people#new', as: 'new'

  patch	 '/(:subdomain.):domain.:tld',   to: 'people#update'
  put 	 '/(:subdomain.):domain.:tld',   to: 'people#update'
  delete '/(:subdomain.):domain.:tld',   to: 'people#destroy'

  resources :people, only: [:index, :create]

  get '/@:nickname',        to: 'nicknames#show',  as: 'nickname'
  get '/chat-people',       to: 'nicknames#index', as: 'chat_people'
end
