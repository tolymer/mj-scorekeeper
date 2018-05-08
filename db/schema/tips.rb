create_table 'tips', force: :cascade do |t|
  t.bigint   'event_id', null: false
  t.bigint   'user_id',  null: false
  t.integer  'point',    null: false
end

add_index 'tips', ['event_id', 'user_id'], unique: true, using: :btree
