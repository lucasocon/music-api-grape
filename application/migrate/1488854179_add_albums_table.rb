Sequel.migration do
  change do
    create_table(:albums) do
      primary_key :id
      String :name
      String :album_art
      Integer :artist_id
      DateTime :created_at
      DateTime :updated_at

      index :artist_id
      index :name
    end
  end
end
