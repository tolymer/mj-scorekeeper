require 'rails_helper'

describe 'events API' do
  let(:current_user) { FactoryBot.create(:user) }
  let(:headers) {
    token = Knock::AuthToken.new(payload: { sub: current_user.id }).token
    { Authorization: "Bearer #{token}" }
  }

  subject(:status) { response.status }
  subject(:body) { JSON.parse(response.body) }

  describe 'GET /events/:event_id/games' do
    let(:now) { Time.now }
    let(:event) { FactoryBot.create(:event) }
    let(:game1) { FactoryBot.create(:game, event: event, created_at: now) }
    let(:game2) { FactoryBot.create(:game, event: event, created_at: now - 1) }
    let(:user1) { FactoryBot.create(:user) }
    let(:user2) { FactoryBot.create(:user) }
    let(:user3) { FactoryBot.create(:user) }
    let(:user4) { FactoryBot.create(:user) }

    before do
      game1.scores.create!(user: user1, point: 10,  rank: 2)
      game1.scores.create!(user: user2, point: -10, rank: 3)
      game1.scores.create!(user: user3, point: -30, rank: 4)
      game1.scores.create!(user: user4, point: 30,  rank: 1)

      game2.scores.create!(user: user1, point: -10,  rank: 3)
      game2.scores.create!(user: user2, point: 100,  rank: 1)
      game2.scores.create!(user: user3, point: -100, rank: 4)
      game2.scores.create!(user: user4, point: 10,   rank: 2)

      get "/events/#{event.id}/games", headers: headers
    end

    specify do
      expect(status).to be 200
      expect(body[0]['id']).to be game2.id
      expect(body[0]['scores']).to contain_exactly(
        { 'user_id' => user1.id, 'point' => -10 },
        { 'user_id' => user2.id, 'point' => 100 },
        { 'user_id' => user3.id, 'point' => -100 },
        { 'user_id' => user4.id, 'point' => 10 },
      )
      expect(body[1]['id']).to be game1.id
      expect(body[1]['scores']).to contain_exactly(
        { 'user_id' => user1.id, 'point' => 10 },
        { 'user_id' => user2.id, 'point' => -10 },
        { 'user_id' => user3.id, 'point' => -30 },
        { 'user_id' => user4.id, 'point' => 30 },
      )
    end
  end

  describe 'POST /events/:event_id/games' do
    let(:event) { FactoryBot.create(:event) }
    let(:user1) { FactoryBot.create(:user) }
    let(:user2) { FactoryBot.create(:user) }
    let(:user3) { FactoryBot.create(:user) }
    let(:user4) { FactoryBot.create(:user) }
    let(:params) do
      {
        scores: [
          { user_id: user1.id, point: 10 },
          { user_id: user2.id, point: -10 },
          { user_id: user3.id, point: 30 },
          { user_id: user4.id, point: -30 },
        ]
      }
    end

    before do
      post "/events/#{event.id}/games", params: params, headers: headers
    end

    specify do
      game = event.games.take
      expect(status).to be 201
      expect(game.scores.size).to be 4

      user1_score = game.scores.find_by(user_id: user1.id)
      expect(user1_score.point).to eq 10
      expect(user1_score.rank).to eq 2

      user2_score = game.scores.find_by(user_id: user2.id)
      expect(user2_score.point).to eq -10
      expect(user2_score.rank).to eq 3

      user3_score = game.scores.find_by(user_id: user3.id)
      expect(user3_score.point).to eq 30
      expect(user3_score.rank).to eq 1

      user4_score = game.scores.find_by(user_id: user4.id)
      expect(user4_score.point).to eq -30
      expect(user4_score.rank).to eq 4
    end
  end
end
