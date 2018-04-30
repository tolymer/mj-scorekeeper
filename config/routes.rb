Rails.application.routes.draw do
  root to: 'root#index'
  post 'user_token' => 'user_token#create'

  resource :current_user, only: %i(show) do
    get :groups
  end
  resources :users, only: %i(show create)
  resources :groups, only: %i(show create update) do
    resources :members, only: %i(index create), controller: 'group_members'
    resources :events, only: %i(index show create update destroy), shallow: true do
      resources :members, only: %i(index create), controller: 'event_members'
      resources :games, only: %i(index create update destroy)
      resources :tips, only: %i(index create)
    end
    member do
      get :stats
    end
  end

  resources :swagger, only: [:index]
end
