Rails.application.routes.draw do

  # landing
  root 'dashboard#index'

  # documentation
  get 'docs' => 'docs#index'

  # user sessions
  get  'login'       => 'sessions#login'
  get  'add_account' => 'sessions#add_account'
  get  'switch/:key' => 'sessions#switch', as: :switch, key: /[^\/]+/
  get  'logout'      => 'sessions#logout'
  post 'login'       => 'sessions#do_login'
  post 'add_account' => 'sessions#do_add_account'

  # account creation
  get  'register' => 'register#new'
  post 'register' => 'register#create'

  # forgot password
  get  'forgot'     => 'password_reset#new'
  post 'forgot'     => 'password_reset#create'
  get  'forgot/:id' => 'password_reset#show', as: :reset_password
  put  'forgot/:id' => 'password_reset#update'

  # account
  resource :account

  # client credentials
  resources :credentials, only: [:index, :create, :destroy]

  # pmp api proxy
  get 'proxy/public(/*other)'  => 'proxy#public_proxy',       as: :public_proxy
  get 'proxy/current(/*other)' => 'proxy#current_user_proxy', as: :user_proxy

end
