Rails.application.routes.draw do
  root to: 'root#index'
  get 'auth/:provider/callback' => 'user_token#create'

  resource :current_user, only: %i(show) do
    get :groups
  end
  resources :sessions, only: [:create, :destroy]
  resources :users, only: %i(show update)
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
