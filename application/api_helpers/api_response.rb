class Api
  module ApiResponse
    extend Grape::API::Helpers

    def api_response response
      if response.key? :error_type
        case response[:error_type].to_sym
        when :not_found
          status 404
        when :forbidden
          status 403
        else
          status 400
        end
      else
        status 200
      end
      response
    end
  end
end
