create_table 'guest_tips', force: :cascade do |t|
  t.bigint   'event_id',  null: false
  t.bigint   'member_id', null: false
  t.integer  'point',           null: false
end

add_index 'guest_tips', ['event_id', 'member_id'], unique: true, using: :btree
