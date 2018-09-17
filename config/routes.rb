Rails.application.routes.draw do

  # landing
  root 'dashboard#index'

  # json stats
  get 'stats' => 'dashboard#stats'

  # documentation
  get 'guides'  => 'docs#users'
  get 'docs'    => 'docs#developers'
  get 'terms'   => 'docs#terms_of_use'

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

  # pmp search engine(s)
  get 'search'        => 'search#prod_search',    as: :prod_search
  get 'sandboxsearch' => 'search#sandbox_search', as: :sandbox_search

  # pmp api proxy
  get 'proxy/sandbox(/*other)' => 'proxy#public_proxy',       as: :sandbox_proxy, defaults: { proxy_env: 'sandbox' }
  get 'proxy/public(/*other)'  => 'proxy#public_proxy',       as: :public_proxy, defaults: { proxy_env: 'production' }
  get 'proxy/current(/*other)' => 'proxy#current_user_proxy', as: :user_proxy

end
