Sequel.migration do
  change do
    create_table(:playlists_songs) do
      Integer :playlist_id
      Integer :song_id
      String :name

      index :playlist_id
      index :song_id
      index :name
    end
  end
end
