Sequel.migration do
  change do
    create_table(:playlists_songs) do
      primary_key :id
      Integer :playlist_id
      Integer :song_id

      index [:playlist_id, :song_id], unique: true
    end
  end
end
