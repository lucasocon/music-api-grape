class Api
  module Entities
    class Artist < Grape::Entity
      expose :name
      expose :bio
      expose :albums, using: Entities::Album
    end
  end
end
