Rails.application.routes.draw do
  root 'about#home'

  get '/@:nickname',        to: "people#nickname"
  get '/:domain.:tld',      to: "people#show"
  get '/:domain.:tld/edit', to: "people#edit"
  get '/new',               to: "people#new", as: "new"

  patch	'/:domain.:tld',    to: "people#update"
  put 	'/:domain.:tld',    to: "people#update"

  delete	'/:domain.:tld',  to: "people#destroy"

  resources :people, only: [:index, :create]
end
