require 'api_constraints'

Rails.application.routes.draw do
  # devise_for :users,
    # controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }
  # ,
  #   :path_prefix => 'api/v1',
  #   defaults: { format: :json },
  #   controllers: {
  #       sessions: 'users/sessions'
  #     }

  # Api definition
  namespace :api, defaults: { format: :json },
                              constraints: { subdomain: 'api' }, path: '/'  do
    devise_for :users,
      controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }
    scope module: :v1 do
        resources :users, :only => [:show, :create, :update, :destroy]
    end
  end
end