class Api
  module Entities
    class Artist < Grape::Entity; end
    class ArtistWithoutAlbum < Artist; end
    class Album < Grape::Entity; end
    class AlbumWithoutArtist < Album; end
    class Song < Grape::Entity; end
    class Playlist < Grape::Entity; end
  end
end
