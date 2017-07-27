Rails.application.routes.draw do

  resources :contents
  resources :groups
  resources :events
  devise_for :users
  resources :usermails

  get 'home/email'
  get 'home/index'
  get 'userpop3/setpop/:id' => 'userpop3#setpop'
  get 'usermail/insertmail/:id' => 'usermail#insertmail'

  devise_scope :user do
    authenticated :user do
      root 'home#index', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
