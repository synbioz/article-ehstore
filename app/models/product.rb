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
      response = Product.search({
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
      })
      response.response["facets"][facet]["terms"].sort_by{ |f| f['count'] }.map{ |f| f['term']}
    end

    def search
      response =
        case @query
        when Hash
          Product.search({
            size: 1000,
            filter: {
              and: filters
            }
          })
        else
          Product.search(@query)
        end

      response.records
    end

    def property_keys
      @property_keys ||=
        begin
          query = 'select distinct k from (select skeys(properties) as k from products) as dt'
          results = ActiveRecord::Base.connection.execute(query)
          results.each_with_object([]) { |rows, columns| columns << rows['k'] }
        end
    end

  private

    def filters
      @query.each_with_object([]) do |(key, values), filters|
        filters << { terms: { "properties.#{key}" => values } }
      end
    end
  end
end
