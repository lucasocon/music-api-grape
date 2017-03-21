Sequel.migration do
  change do
    create_table(:playlists) do
      primary_key :id
      String :name

      index :name
    end
  end
end
