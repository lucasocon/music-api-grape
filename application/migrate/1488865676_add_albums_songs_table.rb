Sequel.migration do
  change do
    create_table(:albums_songs) do
      primary_key :id
      Integer :album_id
      Integer :song_id

      index [:album_id, :song_id], unique: true
    end
  end
end
