Sequel.migration do
  change do
    create_table(:user_tokens) do
      primary_key :id

      String :access_token
      DateTime :expires_at
      Integer :user_id
      Boolean :active

      index :user_id, unique: false
      index :access_token, unique: true
    end
  end
end
