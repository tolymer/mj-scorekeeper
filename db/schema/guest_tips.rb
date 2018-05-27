create_table 'guest_tips', force: :cascade do |t|
  t.bigint   'guest_event_id',  null: false
  t.bigint   'guest_member_id', null: false
  t.integer  'point',           null: false
end

add_index 'guest_tips', ['guest_event_id', 'guest_member_id'], unique: true, using: :btree
