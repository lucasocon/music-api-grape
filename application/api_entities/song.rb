class Api
  module Entities
    class Song < Grape::Entity
      expose :name
      expose :genre
      expose :banner
      expose :promotion
      expose :duration
      expose :featured

      expose :album, using: Entities::Album
      expose :artist, using: Entities::Artist
      expose :playlists, using: Entities::Playlist
    end
  end
end
