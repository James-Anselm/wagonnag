Rails.application.routes.draw do
  get 'cars/new'

  get 'password_resets/new'

  get 'password_resets/edit'

  root             'static_pages#home'
  get 'about'   => 'static_pages#about'
  get 'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  resources(:users)
  resources(:account_activations, only: [:edit])
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :cars do
    resources :maintenance_items
  end

  post 'update_odometer' => 'cars#update_odometer'
  get 'get_update_odometer_form' => 'cars#get_update_odometer_form'

  resources :maintenance_items, only: [:update]
end