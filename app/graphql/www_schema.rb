class WwwSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)
end

# GraphQLDocs.build(schema: WwwSchema.to_graphql, output: "./app/views/documentation")
