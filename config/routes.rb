Rails.application.routes.draw do
  get 'nicknames/index'

  get 'nicknames/show'

  root 'about#home'

  get '/:domain.:tld',      to: 'people#show'
  get '/:domain.:tld/edit', to: 'people#edit'
  get '/new',               to: 'people#new', as: 'new'

  patch	'/:domain.:tld',    to: 'people#update'
  put 	'/:domain.:tld',    to: 'people#update'

  delete	'/:domain.:tld',  to: 'people#destroy'

  resources :people, only: [:index, :create]
  
  get '/@:nickname',        to: 'nicknames#show',  as: 'nickname'
  get '/chat-people',       to: 'nicknames#index', as: 'chat_people'
end
