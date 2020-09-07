Hanami::Model.migration do
  change do
    create_table :authors do
      primary_key :id

      column :first_name, String, null: false
      column :last_name, String, null: false
      column :profile, String, null: true
      column :avatar, String, null: true

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
