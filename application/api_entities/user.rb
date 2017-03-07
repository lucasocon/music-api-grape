class Api
  module Entities
    class User < Grape::Entity
      format_with(:iso_timestamp) { |dt| dt.iso8601 }

      expose :id
      expose :first_name
      expose :last_name
      expose :email

      with_options(format_with: :iso_timestamp) do
        expose :born_on, if: :born_on
        expose :created_at
        expose :updated_at
      end
    end
  end
end
