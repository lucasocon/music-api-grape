class Api
  module Models
    class Album < Sequel::Model(:albums)
      many_to_one :artist
    end
  end
end
