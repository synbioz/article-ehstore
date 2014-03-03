class Product < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  class SearchService
    attr_reader :query

    def initialize(query=nil)
      @query = query
    end

    def autocomplete(facet, term)
      return [] unless property_keys.include?(facet)

      field = "properties.#{facet}"
      es_params = {
        size: 0,
        query: {
          prefix: {
            field => term
          }
        },
        facets: {
          facet => {
            terms: {
              field: field
            }
          }
        }
      }
      response = Product.search(es_params)
      response.response["facets"][facet]["terms"].map{ |f| f['term']}
    end

    def search
      es_params = {
        size: 1000,
        filter: {
          and: @query.map{ |key, values| { terms: { "properties.#{key}" => values } } }
        }
      }
      Product.search(es_params).records
    end

    def property_keys
      @property_keys ||=
        begin
          query = 'select distinct k from (select skeys(properties) as k from products) as dt'
          results = ActiveRecord::Base.connection.execute(query)
          results.each_with_object([]) { |rows, columns| columns << rows['k'] }
        end
    end
  end
end
