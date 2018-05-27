create_table 'guest_members', force: :cascade do |t|
  t.string   'name',           null: false
  t.bigint   'event_id', null: false
  t.datetime 'created_at',     null: false
end

add_index 'guest_members', 'event_id', using: :btree
