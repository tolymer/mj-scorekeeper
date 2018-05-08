create_table 'game_scores', force: :cascade do |t|
  t.bigint   'game_id',  null: false
  t.bigint   'user_id',  null: false
  t.integer  'point',    null: false
  t.integer  'rank',     null: false
end

add_index 'game_scores', ['game_id', 'user_id'], unique: true, using: :btree
