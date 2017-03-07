class Api
  module Models
    class Playlist < Sequel::Model(:playlists)
      many_to_many :songs
    end
  end
end
