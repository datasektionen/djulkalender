DB.alter_table(:people) do
  add_column :username, String, null: false, default: ""
end
