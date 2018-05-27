create_table 'guest_game_scores', force: :cascade do |t|
  t.bigint   'game_id',   null: false
  t.bigint   'member_id', null: false
  t.integer  'point',           null: false
end

add_index 'guest_game_scores', ['game_id', 'member_id'], unique: true, using: :btree
