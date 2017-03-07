Sequel.migration do
  change do
    create_table(:artists) do
      primary_key :id
      String :name
      String :bio, text: true

      index :name
    end
  end
end
