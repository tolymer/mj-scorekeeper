create_table 'guest_games', force: :cascade do |t|
  t.bigint   'guest_event_id',   null: false
  t.datetime 'created_at', null: false
end

add_index 'guest_games', ['guest_event_id', 'created_at'], using: :btree
