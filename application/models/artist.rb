class Api
  module Models
    class Artist < Sequel::Model(:artists)
      one_to_many :albums
      plugin :association_dependencies, albums: :destroy

      def songs
        albums_dataset.association_join(:songs).select_all(:songs)
      end
    end
  end
end
