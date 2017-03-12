class Api
  module Models
    class Album < Sequel::Model(:albums)
      many_to_one :artist
      one_to_many :songs
      plugin :association_dependencies, songs: :destroy
    end
  end
end
