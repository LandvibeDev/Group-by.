Rails.application.routes.draw do

  devise_for :users

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

  get 'home/calendar'

  post 'home/load_event' => 'home#load_event'
  post 'home/create_event' => 'home#create_event'
  post 'home/edit_event' => 'home#edit_event'
  post 'home/delete_event' => 'home#delete_event'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
