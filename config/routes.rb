Rails.application.routes.draw do
  get "pictures/index"
  get "pictures/show"
  get "pictures/new"
  get "users/index"
  get "users/show"
  get "users/edit"
  get "users/delete"
  get "users/new"



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

  #check exception
  post "divide", controller: "products", action: :divide, as: :divide

  resources :products do
    resource :picture
  end
end
