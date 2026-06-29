Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token
  #get all products
  get "/products", to: "products#index", as: :products

  #create
  #render form for create new product
  get "/products/new", to: "products#new"
  post "/products", to: "products#create"

  #read
  get "/products/:id", to: "products#show", as: :product



  #update
  get "products/:id/edit", to: "products#edit", as: :edit_product
  put "products/:id", to: "products#update"
  patch "products/:id", to: "products#update"

  #delete
  delete "products/:id", to: "products#destroy"

  root "products#index"

  #if we dont want to write above all crud we can use resources
  resources :products

end
