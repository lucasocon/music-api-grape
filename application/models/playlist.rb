class Api
  module Models
    class Playlist < Sequel::Model(:playlists)
      many_to_one :user
      many_to_many :songs, left_key: :playlist_id, right_key: :song_id,
                           join_table: :playlists_songs

      plugin :association_dependencies, songs: :nullify
    end
  end
end
