Rails.application.routes.draw do

  # landing
  root 'dashboard#index'

  # user sessions
  get  'login'       => 'sessions#login'
  get  'add_account' => 'sessions#add_account'
  get  'switch/:id'  => 'sessions#switch', as: :switch
  get  'register'    => 'sessions#register'
  get  'forgot'      => 'sessions#forgot_password'
  get  'logout'      => 'sessions#logout'
  post 'login'       => 'sessions#do_login'
  post 'add_account' => 'sessions#do_add_account'
  post 'register'    => 'sessions#do_register'
  post 'forgot'      => 'sessions#do_forgot_password'

  # client credentials
  resources :credentials, only: [:index, :create, :destroy]

end
