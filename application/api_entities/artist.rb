require_relative 'entities'

class Api
  module Entities
    class Artist < Grape::Entity
      expose :name
      expose :bio
      expose :albums, using: Entities::AlbumWithoutArtist
    end

    class ArtistWithoutAlbum < Artist
      unexpose :albums
    end
  end
end
