create_table 'event_members', force: :cascade do |t|
  t.bigint   'user_id',    null: false
  t.bigint   'event_id',   null: false
  t.datetime 'created_at', null: false
end

add_index 'event_members', ['user_id', 'event_id'], unique: true, using: :btree
