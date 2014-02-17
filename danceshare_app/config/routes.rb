DanceshareApp::Application.routes.draw do

  root "welcome#index"
  
  # resources :user do
  resources :companies do
    resources :performances, except: [:destroy]
  end

  resources :performances do
    resources :reviews do
    end
  end

  get "/login", to: "session#new"
  post "/session", to: "session#create"
  delete "/session", to: "session#destroy"

  get "/users/:id/reviews", to: "users#reviews_index"

  resources :users do
  end

end
