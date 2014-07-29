Rails.application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'users' }

  root 'adverts#index'
  get 'filter' => 'adverts#filter'

  resources :adverts do
    member do
      get 'change'
      get 'logs'
      match 'change_state', via: [:put, :patch]
    end
    get 'awaiting_publication', on: :collection
  end

  devise_scope :user do
    get 'users/adverts/', to: 'users#adverts'
    get 'account', to: 'users#account'
    resources :users, only: [:index, :show, :update, :edit]
  end

  resources :categories

end
