require 'rails_helper'

describe 'guest games API' do
  subject(:status) { response.status }
  subject(:body) { JSON.parse(response.body) }

  describe 'GET /guest_events/:token/guest_games' do
    let(:now) { Time.now }
    let(:event) { FactoryBot.create(:guest_event) }
    let(:game1) { FactoryBot.create(:guest_game, event: event, created_at: now) }
    let(:game2) { FactoryBot.create(:guest_game, event: event, created_at: now - 1) }
    let(:member1) { FactoryBot.create(:guest_member) }
    let(:member2) { FactoryBot.create(:guest_member) }
    let(:member3) { FactoryBot.create(:guest_member) }
    let(:member4) { FactoryBot.create(:guest_member) }

    before do
      game1.scores.create!(member: member1, point: 10)
      game1.scores.create!(member: member2, point: -10)
      game1.scores.create!(member: member3, point: -30)
      game1.scores.create!(member: member4, point: 30)

      game2.scores.create!(member: member1, point: -10)
      game2.scores.create!(member: member2, point: 100)
      game2.scores.create!(member: member3, point: -100)
      game2.scores.create!(member: member4, point: 10)

      get "/guest_events/#{event.token}/guest_games"
    end

    specify do
      expect(status).to be 200
      expect(body[0]['id']).to be game2.id
      expect(body[0]['scores']).to contain_exactly(
        { 'member_id' => member1.id, 'point' => -10 },
        { 'member_id' => member2.id, 'point' => 100 },
        { 'member_id' => member3.id, 'point' => -100 },
        { 'member_id' => member4.id, 'point' => 10 },
      )
      expect(body[1]['id']).to be game1.id
      expect(body[1]['scores']).to contain_exactly(
        { 'member_id' => member1.id, 'point' => 10 },
        { 'member_id' => member2.id, 'point' => -10 },
        { 'member_id' => member3.id, 'point' => -30 },
        { 'member_id' => member4.id, 'point' => 30 },
      )
    end
  end

  describe 'POST /guest_events/:token/guest_games' do
    let(:event) { FactoryBot.create(:guest_event) }
    let(:member1) { FactoryBot.create(:guest_member) }
    let(:member2) { FactoryBot.create(:guest_member) }
    let(:member3) { FactoryBot.create(:guest_member) }
    let(:member4) { FactoryBot.create(:guest_member) }
    let(:params) do
      {
        scores: [
          { member_id: member1.id, point: 10 },
          { member_id: member2.id, point: -10 },
          { member_id: member3.id, point: 30 },
          { member_id: member4.id, point: -30 },
        ]
      }
    end

    before do
      post "/guest_events/#{event.token}/guest_games", params: params
    end

    specify do
      game = event.games.take
      expect(status).to be 201
      expect(game.scores.size).to be 4

      member1_score = game.scores.find_by(member_id: member1.id)
      expect(member1_score.point).to eq 10

      member2_score = game.scores.find_by(member_id: member2.id)
      expect(member2_score.point).to eq(-10)

      member3_score = game.scores.find_by(member_id: member3.id)
      expect(member3_score.point).to eq 30

      member4_score = game.scores.find_by(member_id: member4.id)
      expect(member4_score.point).to eq(-30)
    end
  end

  describe 'PATCH /guest_games/:id' do
    let(:game) { FactoryBot.create(:guest_game) }
    let(:member1) { FactoryBot.create(:guest_member) }
    let(:member2) { FactoryBot.create(:guest_member) }
    let(:member3) { FactoryBot.create(:guest_member) }
    let(:member4) { FactoryBot.create(:guest_member) }

    before do
      game.scores.create!(member: member1, point: 10)
      game.scores.create!(member: member2, point: -10)
      game.scores.create!(member: member3, point: -30)
      game.scores.create!(member: member4, point: 30)
      params = {
        scores: [
          { member_id: member1.id, point: -100 },
          { member_id: member2.id, point: 20 },
          { member_id: member3.id, point: -20 },
          { member_id: member4.id, point: 100 },
        ]
      }
      patch "/guest_games/#{game.id}", params: params
    end

    specify do
      expect(status).to be 200

      member1_score = game.scores.find_by(member_id: member1.id)
      expect(member1_score.point).to eq(-100)

      member2_score = game.scores.find_by(member_id: member2.id)
      expect(member2_score.point).to eq(20)

      member3_score = game.scores.find_by(member_id: member3.id)
      expect(member3_score.point).to eq(-20)

      member4_score = game.scores.find_by(member_id: member4.id)
      expect(member4_score.point).to eq 100
    end
  end

  describe 'DELETE /guest_games/:id' do
    let(:game) { FactoryBot.create(:guest_game) }
    let(:member1) { FactoryBot.create(:guest_member) }
    let(:member2) { FactoryBot.create(:guest_member) }
    let(:member3) { FactoryBot.create(:guest_member) }
    let(:member4) { FactoryBot.create(:guest_member) }

    before do
      game.scores.create!(member: member1, point: 10)
      game.scores.create!(member: member2, point: -10)
      game.scores.create!(member: member3, point: -30)
      game.scores.create!(member: member4, point: 30)
      delete "/guest_games/#{game.id}"
    end

    specify do
      expect(status).to be 200
      expect(GuestGame.where(id: game.id).exists?).to be false
      expect(game.scores.size).to be 0
    end
  end
end
