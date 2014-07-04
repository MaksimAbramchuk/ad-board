Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root 'adverts#index'

  get 'account/role', to: 'accounts#role'
  post 'account/role/change', to: 'accounts#change_role'
  get 'account', to: 'accounts#index'
  get 'adverts/awaiting_publication', to: 'adverts#awaiting_publication'
  get 'users/all', to: 'users#all'
  get 'users/:id/', to: 'users#show', as: 'user'
  get 'account/adverts/', to: 'accounts#adverts'
  post 'adverts/:id/change', to: 'comments#creater'
  get 'adverts/:id/logs/', to: 'adverts#logs', as: 'advert_logs'
  get '/search/result', to: 'search#result'

  resources :adverts do
    get 'change'
    match 'change' => 'adverts#change_state', via: [:put, :patch]
  end

  resources :categories
end
