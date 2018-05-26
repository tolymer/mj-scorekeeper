require 'factory_bot'
Dir[Rails.root.join('spec/support/factories/*.rb')].each {|f| require f }

## Create users
hiloki   = FactoryBot.create(:user, name: 'hiloki')
hokaccha = FactoryBot.create(:user, name: 'hokaccha')
_1000ch  = FactoryBot.create(:user, name: '1000ch')
tan_yuki = FactoryBot.create(:user, name: 'tan-yuki')

## Create group
tolymer_group = FactoryBot.create(:group,
                                  name: 'tolymer',
                                  description: 'hilokiと愉快な仲間たち')

## Create group members
FactoryBot.create(:group_member, user: hiloki,   group: tolymer_group)
FactoryBot.create(:group_member, user: hokaccha, group: tolymer_group)
FactoryBot.create(:group_member, user: _1000ch,  group: tolymer_group)
FactoryBot.create(:group_member, user: tan_yuki, group: tolymer_group)

## Create event
event = FactoryBot.create(:event,
                          title: '西日暮里付近で麻雀したい59打目',
                          date: '2018-01-06',
                          group: tolymer_group)

## Create event members
FactoryBot.create(:event_member, user: hiloki,   event: event)
FactoryBot.create(:event_member, user: hokaccha, event: event)
FactoryBot.create(:event_member, user: _1000ch,  event: event)
FactoryBot.create(:event_member, user: tan_yuki, event: event)

## Create games
game1 = FactoryBot.create(:game, event: event)
FactoryBot.create(:game_score, game: game1, rank: 3, point: -11, user: hiloki)
FactoryBot.create(:game_score, game: game1, rank: 2, point: 9,   user: hokaccha)
FactoryBot.create(:game_score, game: game1, rank: 1, point: 53,  user: _1000ch)
FactoryBot.create(:game_score, game: game1, rank: 4, point: -51, user: tan_yuki)

game2 = FactoryBot.create(:game, event: event)
FactoryBot.create(:game_score, game: game2, rank: 1, point: 55,  user: hiloki)
FactoryBot.create(:game_score, game: game2, rank: 4, point: -50, user: hokaccha)
FactoryBot.create(:game_score, game: game2, rank: 3, point: -17, user: _1000ch)
FactoryBot.create(:game_score, game: game2, rank: 2, point: 12,  user: tan_yuki)

game3 = FactoryBot.create(:game, event: event)
FactoryBot.create(:game_score, game: game3, rank: 3, point: -17, user: hiloki)
FactoryBot.create(:game_score, game: game3, rank: 2, point: 10,  user: hokaccha)
FactoryBot.create(:game_score, game: game3, rank: 4, point: -44, user: _1000ch)
FactoryBot.create(:game_score, game: game3, rank: 1, point: 51,  user: tan_yuki)

game4 = FactoryBot.create(:game, event: event)
FactoryBot.create(:game_score, game: game4, rank: 1, point: 52,  user: hiloki)
FactoryBot.create(:game_score, game: game4, rank: 4, point: -53, user: hokaccha)
FactoryBot.create(:game_score, game: game4, rank: 2, point: 17,  user: _1000ch)
FactoryBot.create(:game_score, game: game4, rank: 3, point: -16, user: tan_yuki)

game5 = FactoryBot.create(:game, event: event)
FactoryBot.create(:game_score, game: game5, rank: 2, point: 18,  user: hiloki)
FactoryBot.create(:game_score, game: game5, rank: 3, point: -8,  user: hokaccha)
FactoryBot.create(:game_score, game: game5, rank: 1, point: 56,  user: _1000ch)
FactoryBot.create(:game_score, game: game5, rank: 4, point: -66, user: tan_yuki)

game6 = FactoryBot.create(:game, event: event)
FactoryBot.create(:game_score, game: game6, rank: 4, point: -47, user: hiloki)
FactoryBot.create(:game_score, game: game6, rank: 1, point: 60,  user: hokaccha)
FactoryBot.create(:game_score, game: game6, rank: 2, point: 10,  user: _1000ch)
FactoryBot.create(:game_score, game: game6, rank: 3, point: -23, user: tan_yuki)

game7 = FactoryBot.create(:game, event: event)
FactoryBot.create(:game_score, game: game7, rank: 1, point: 42,  user: hiloki)
FactoryBot.create(:game_score, game: game7, rank: 3, point: -16, user: hokaccha)
FactoryBot.create(:game_score, game: game7, rank: 4, point: -30, user: _1000ch)
FactoryBot.create(:game_score, game: game7, rank: 2, point: 4,   user: tan_yuki)

## Create tip
FactoryBot.create(:tip, event: event, point: 24,  user: hiloki)
FactoryBot.create(:tip, event: event, point: -18, user: hokaccha)
FactoryBot.create(:tip, event: event, point: 8,   user: _1000ch)
FactoryBot.create(:tip, event: event, point: -14, user: tan_yuki)
