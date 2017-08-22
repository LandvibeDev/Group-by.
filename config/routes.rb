Rails.application.routes.draw do
  resources :projects do
    get 'calendar'
    post 'create_teamEvent'
    post 'new_load_teamEvent'
    resource :users
    resource :events
  end

  # post 'projects/:project_id/create_teamEvent/:id' => 'projects#create_teamEvent'
  post 'projects/:id/current_load_teamEvent/:event_id' => 'projects#current_load_teamEvent'
  post 'projects/:id/load_teamEvent' => 'projects#load_teamEvent'
  post 'projects/:project_id/edit_teamEvent/:id' => 'projects#edit_teamEvent'
  delete 'projects/:project_id/delete_teamEvent/:id' => 'projects#delete_teamEvent'

  devise_for :users

  resources :groups, only: [:index, :edit, :update] do
    resource :users
    resource :contents
  end

  resources :userpop3s, only: [:index] do
    resources :usermails
  end

  resources :users do
    get 'inviteShow'
    get 'all'
    get 'search' => 'users#search'
    get 'search/:word' => 'users#search'

    patch '' => 'users#update_info'

    resources :groups do
      get 'join'
    end

    resources :projects do
      get 'join'
      get 'inviteCreate'
      get 'invite'
    end

  end

  get 'delete_push/:id' =>'users#delete_push'

  resources :events

  get 'home/index'
  get 'userpop3/setpop/:id' => 'userpop3#setpop'

  devise_scope :user do
    authenticated :user do
      root 'home#index', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  get 'home/calendar_month'
  get 'groups/comments_create/:content_id/:group_id' => 'groups#comments_create'

  post 'home/current_load_event/:id' => 'home#current_load_event'
  post 'home/new_load_event' => 'home#new_load_event'
  post 'home/load_event' => 'home#load_event'
  post 'home/create_event' => 'home#create_event'
  post 'home/edit_event' => 'home#edit_event'
  post 'home/delete_event' => 'home#delete_event'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
