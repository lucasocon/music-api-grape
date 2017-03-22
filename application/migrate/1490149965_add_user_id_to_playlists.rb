Sequel.migration do
  up do
    add_column :playlists, :user_id, Integer
    add_index  :playlists, :user_id
  end

  down do
    drop_column :playlists, :user_id
  end
end
