create_table 'users', force: :cascade do |t|
  t.string   'name',            null: false
  t.string   'password_digest', null: false
  t.datetime 'created_at',      null: false
end

add_index 'users', 'name', name: 'idx_name', unique: true, using: :btree
