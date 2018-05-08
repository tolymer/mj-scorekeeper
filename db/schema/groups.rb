create_table 'groups', force: :cascade do |t|
  t.string   'name',        null: false
  t.text     'description', null: false, default: ''
  t.datetime 'created_at',  null: false
end

add_index 'groups', 'name', using: :btree
