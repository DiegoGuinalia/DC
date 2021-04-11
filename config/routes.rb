Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: proc { [404, {}, ["Not found."]] }

  namespace :api do
    namespace :v1 do
      post '/orders/normalize_data', to: 'orders#normalize_data'
    end
  end
end
