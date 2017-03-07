class Api
  module Entities
    class Playlist < Grape::Entity
      expose :name
      expose :songs, using: Entities::Song
    end
  end
end
