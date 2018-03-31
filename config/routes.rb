Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'

  resources :current_user, only: %i(index)
  resources :users, only: %i(show create)
  resources :groups, only: %i(show create update) do
    resources :members, only: %i(index create), controller: 'group_members'
    resources :events, only: %i(index show create update), shallow: true do
      resources :members, only: %i(index create), controller: 'event_members'
      resources :games, only: %i(index create update)
    end
  end

  resources :swagger, only: [:index]
end
