Rails.application.routes.draw do
  resources :projects do
    get 'calendar'
    post 'save'
    get 'notfind', on: :collection
    post 'create_teamEvent'
    post 'new_load_teamEvent'
    post 'image_teamEvent'
    resource :users
    resource :events
  end

  post 'projects/:event_id/user_event_add' => 'projects#user_event_add'
  put 'projects/:event_id/user_event_complete' => 'projects#user_event_complete'

  # post 'projects/:project_id/create_teamEvent/:id' => 'projects#create_teamEvent'
  post 'projects/:id/current_load_teamEvent/:event_id' => 'projects#current_load_teamEvent'
  post 'projects/:id/load_teamEvent' => 'projects#load_teamEvent'
  post 'projects/:project_id/edit_teamEvent/:id' => 'projects#edit_teamEvent'
  delete 'projects/:project_id/delete_teamEvent/:id' => 'projects#delete_teamEvent'

  devise_for :users, :controllers => { sessions: 'users/sessions' }

  resources :groups do
    resource :users
    resource :contents
  end

  resources :userpop3s, only: [:index] do
    resources :usermails
  end

  resources :users do
    get 'inviteShow', on: :collection
    get 'all', on: :collection
    get 'search' => 'users#search'
    get 'search/:word' => 'users#search'

    patch '' => 'users#update_info'

    resources :groups do
      get 'join'
    end

    resources :projects do
      get 'admin_user_add'
      get 'admin_user_destroy'
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
  post 'groups/comments_create/:content_id/:group_id' => 'groups#comments_create'

  post 'home/current_load_event/:id' => 'home#current_load_event'
  post 'home/new_load_event' => 'home#new_load_event'
  post 'home/load_event' => 'home#load_event'
  post 'home/create_event' => 'home#create_event'
  post 'home/edit_event' => 'home#edit_event'
  post 'home/delete_event' => 'home#delete_event'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #viewer
  get 'viewer/index'

  #error
  match "/404", :to => "errors#not_found", :via => :all
  match "/500", :to => "errors#internal_server_error", :via => :all
end
