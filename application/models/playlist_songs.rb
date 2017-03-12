class Api
  module Models
    class PlaylistSong < Sequel::Model(:playlists_songs)
      one_to_many :playlists
      one_to_many :songs
    end
  end
end
