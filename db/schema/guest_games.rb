create_table 'guest_games', force: :cascade do |t|
  t.bigint   'event_id',   null: false
  t.datetime 'created_at', null: false
end

add_index 'guest_games', ['event_id', 'created_at'], using: :btree
