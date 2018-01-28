Rails.application.routes.draw do

  namespace :api, defaults: { format: :json }, path: '/'  do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      namespace :auth_user, defaults: { format: :json }  do
       
        post 'login', to: 'users#login'
        post 'signUp', to: 'users#signup'
      end
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
