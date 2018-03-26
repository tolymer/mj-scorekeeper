Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'

  resources :users, only: %i(show create)
  resources :groups, only: %i(show create) do
    resources :members, only: %i(index create), controller: 'group_members'
  end
end
