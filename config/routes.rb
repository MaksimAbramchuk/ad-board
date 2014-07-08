Rails.application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root 'adverts#index'

  get 'account', to: 'accounts#index'
  get 'account/adverts/', to: 'accounts#adverts'

  get '/search/result', to: 'search#result'

  resources :adverts do
    member do
      get 'change'
      get 'logs'
      match 'change_state', via: [:put, :patch]
    end
    get 'awaiting_publication', on: :collection
  end

  resources :users, only: [:index, :show, :edit, :update]
  resources :categories

end
