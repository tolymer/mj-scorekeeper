create_table 'authentications', force: :cascade do |t|
  t.bigint   'user_id',    null: false
  t.string   'provider',   null: false
  t.string   'uid',        null: false
  t.datetime 'created_at', null: false
end

add_index 'authentications', ['provider', 'uid'], name: 'idx_provider_uid', unique: true, using: :btree
add_index 'authentications', ['user_id'], name: 'idx_user_id', using: :btree
