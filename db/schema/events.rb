create_table 'events', force: :cascade do |t|
  t.bigint   'group_id',   null: false
  t.string   'title',      null: false
  t.date     'date',       null: false
  t.datetime 'created_at', null: false
end

add_index 'events', 'group_id', name: 'idx_group_id', using: :btree
