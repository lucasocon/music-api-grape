Sequel.migration do
  change do
    create_table(:albums) do
      primary_key :id
      String :name
      String :album_art
      foreign_key :artist_id, :artists
      DateTime :created_at
      DateTime :updated_at

      index :artist_id
      index :name
    end
  end
end
