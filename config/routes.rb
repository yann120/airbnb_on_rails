Rails.application.routes.draw do
  get 'room/index'
  get 'room/new'
  get 'room/create'
  get 'room/update'
  get 'room/listing'
  get 'room/pricing'
  get 'room/description'
  get 'room/photo_upload'
  get 'room/amenities'
  get 'room/location'
  root 'pages#home'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", registrations: 'registrations' }
  resources :users, only: [:show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
