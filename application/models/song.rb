class Api
  module Models
    class Song < Sequel::Model(:songs)
      many_to_many :albums, left_key: :song_id, right_key: :album_id,
                            join_table: :albums_songs
      many_to_many :playlists, left_key: :song_id, right_key: :playlist_id,
                               join_table: :playlists_songs

      plugin :association_dependencies, playlists: :nullify
    end
  end
end
