class Api
  module Entities
    class Album < Grape::Entity
      expose :name
      expose :album_art
      expose :artist, using: Entities::Artist
    end
  end
end
