class Api
  module Models
    class AlbumSong < Sequel::Model(:albums_songs)
      one_to_many :albums
      one_to_many :songs
    end
  end
end
