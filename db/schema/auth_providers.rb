create_table 'auth_providers', force: :cascade do |t|
  t.bigint   'user_id',    null: false
  t.string   'name',       null: false
  t.string   'uid',        null: false
  t.datetime 'created_at', null: false
end

add_index 'auth_providers', ['name', 'uid'], unique: true, using: :btree
add_index 'auth_providers', ['user_id'], using: :btree
