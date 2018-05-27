create_table 'guest_events', force: :cascade do |t|
  t.string   'token',       null: false
  t.string   'title',       null: false
  t.text     'description', null: false, default: ''
  t.date     'date',        null: false
  t.datetime 'created_at',  null: false
end

add_index 'guest_events', 'token', unique: true, using: :btree
