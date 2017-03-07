Sequel.migration do
  change do
    create_table(:songs) do
      primary_key :id
      String :name
      String :genre
      String :banner
      String :promotion, text: true
      Integer :duration
      foreign_key :album_id, :albums
      foreign_key :artist_id, :artists
      FalseClass :featured

      index :album_id
      index :artist_id
      index :name
    end
  end
end
