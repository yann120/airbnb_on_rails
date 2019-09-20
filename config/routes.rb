Rails.application.routes.draw do
  root 'pages#home'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", registrations: 'registrations' }
  resources :users, only: [:show]
  resources :rooms, except: [:edit] do
    member do
      get 'listing'
      get 'pricing'
      get 'description'
      get 'photo_upload'
      get 'amenities'
      get 'location'
      get 'preload'
      delete :delete_image_attachment
    end
    resources :reservations, only: [:create]
  end
  resources :reviews, only: [:create, :destroy]
  get '/trips' => 'reservations#trips'
  get '/reservations' => 'reservations#current_reservations'
end
