class Api
  module Entities
    class Song < Grape::Entity
      expose :name
      expose :genre
      expose :banner
      expose :promotion
      expose :duration
      expose :featured
    end
  end
end
