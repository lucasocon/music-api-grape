Sequel.migration do
  change do
    create_table(:playlists_songs) do
      foreign_key :playlist_id, :playlists
      foreign_key :song_id, :songs
      String :name

      index :name
    end
  end
end
