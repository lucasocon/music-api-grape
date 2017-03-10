Sequel.migration do
  change do
    create_table(:songs) do
      primary_key :id
      String :name
      String :genre
      String :banner
      String :promotion, text: true
      Integer :duration
      Integer :album_id
      FalseClass :featured

      index :album_id
      index :name
    end
  end
end
