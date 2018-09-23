Rails.application.routes.draw do
  # if Rails.env.development?
  #   mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  # end
  use_doorkeeper
  mount GraphiQL::Rails::Engine, at: "/", graphql_path: "/graphql"
  post "/login", to: "login#post"
  post "/graphql", to: "graphql#execute"
  namespace :documentation do
    resources :operation, :object, :mutation, :scalar, only: [:index]
    namespace :operation do
      resources :query, :mutation
    end

    namespace :object do
      resources :lineitem, :order, :product, :shop
    end

    namespace :mutation do
      resources :createlineitem, :createorder, :createproduct, :createshop,
        :deletelineitems, :deleteorders, :deleteproducts, :deleteshops,
        :editlineitem, :editorder, :editproduct, :editshops
    end

    namespace :scalar do
      resources :boolean, :float, :int, :string
    end
  end



  resources :documentation, only: [:index] do
    
    # resources :operation, only: [] do
    #   resources :mutation, only: [:index]
    #   resources :query, only: [:index]
    # end
    # resources :object, only: [:index] do
    #   resources :lineitem, only: [:index]
    #   resources :order, only: [:index]
    #   resources :product, only: [:index]
    #   resources :shop, only: [:index]
    # end
    # resources :mutation, only: [] do
    #   resources :createlineitem, only: [:index]
    #   resources :createorder, only: [:index]
    #   resources :createproduct, only: [:index]
    #   resources :createshop, only: [:index]
    #   resources :deletelineitems, only: [:index]
    #   resources :deleteorders, only: [:index]
    #   resources :deleteproducts, only: [:index]
    #   resources :deleteshops, only: [:index]
    #   resources :editlineitem, only: [:index]
    #   resources :editorder, only: [:index]
    #   resources :editproduct, only: [:index]
    #   resources :editshop, only: [:index]
    # end
    # resources :scalar, only: [:index] do
    #   resources :boolean, only: [:index]
    #   resources :float, only: [:index]
    #   resources :int, only: [:index]
    #   resources :string, only: [:index]
    # end
  end

  
  pulse # health check
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
