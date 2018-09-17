Rails.application.routes.draw do
  # if Rails.env.development?
  #   mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  # end
  use_doorkeeper
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/", graphql_path: "/graphql"
  end
  post "/login", to: "login#post"
  post "/graphql", to: "graphql#execute"
  post "/graphql-shops", to: "graphql#post_shop"
  pulse # health check
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
