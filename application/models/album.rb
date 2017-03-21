class Api
  module Models
    class Album < Sequel::Model(:albums)
      many_to_one :artist
      many_to_many :songs, left_key: :album_id, right_key: :song_id,
                           join_table: :albums_songs

      plugin :association_dependencies, songs: :nullify
    end
  end
end
