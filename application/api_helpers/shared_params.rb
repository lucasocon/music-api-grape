class Api
  module SharedParams
    extend Grape::API::Helpers

    params :basic_search do
      optional :query, type: String
      optional :id, types: [Integer, Array[Integer]]
      optional :page, type: Integer, default: 1
      optional :per_page, type: Integer, default: 20
      optional :order, type: String
    end
  end
end
