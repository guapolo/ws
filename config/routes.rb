Rails.application.routes.draw do
  resources :users, only: [:index, :show] do
    resources :group_events
  end

  root to: 'users#index'
end
