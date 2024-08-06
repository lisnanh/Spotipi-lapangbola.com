Rails.application.routes.draw do
  get "statics/index"
  devise_for :users, controller: {
    sessions: 'users/sessions'
  }
  devise_scope :user do
    get '/users/sign_out', to: 'devise/sessions#destroy'
  end

  # Admin namespace
  authenticate :user, -> (user) {user.admin?} do
  namespace :admin do 
    root "dashboards#index" #admindashboards
    resource :songs, param: :id
    resource :artists
    resource :albums
  end
end
  
  # Client namespace
  namespace :client do
    root "dashboards#index"
    get 'statics/about', to: 'statics#about'
    get 'statics/contact', to: 'statics#contact'
    
    resource :artists, only: [:index, :show]
    resource :albums, only: [:index, :show]
    resource :statics 
    resource :songs, only: [:index, :show] do
  end
end
  
  authenticated :user, -> user {user.admin?} do
    root to: 'admin/dashboards#index', as: :admin_root_path
  end
  
  authenticated :user do
    root to: 'client/dashboards#index', as: :client_root_path
  end

  # Define the fallback root path for unautenticated
  unauthenticated do
    root to:'statics#index'
  end

  resources :profils
  resources :albums
  resources :songs, param: :id
  resources :artists


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  get "about" => "statics#about"
  get "contact" => "statics#contact"
end