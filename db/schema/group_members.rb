create_table 'group_members', force: :cascade do |t|
  t.bigint   'user_id',    null: false
  t.bigint   'group_id',   null: false
  t.datetime 'created_at', null: false
end

add_index 'group_members', ['user_id', 'group_id'], unique: true, using: :btree
