class Api
  module Models
    class Artist < Sequel::Model(:artists)
      one_to_many :albums
    end
  end
end
