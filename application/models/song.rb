class Api
  module Models
    class Song < Sequel::Model(:songs)
      many_to_one :album
      many_to_one :artist
      many_to_many :playlists
    end
  end
end
