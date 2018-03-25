create_table 'groups', force: :cascade do |t|
  t.string   'name',       null: false
  t.datetime 'created_at', null: false
end

add_index 'groups', 'name', name: 'idx_groups_user_id', using: :btree
