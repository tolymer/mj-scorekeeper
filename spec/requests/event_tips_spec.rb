require 'rails_helper'

describe 'tips API' do
  let(:current_user) { FactoryBot.create(:user) }
  let(:headers) {
    token = Knock::AuthToken.new(payload: { sub: current_user.id }).token
    { Authorization: "Bearer #{token}" }
  }

  subject(:status) { response.status }
  subject(:body) { JSON.parse(response.body) }

  let(:event) { FactoryBot.create(:event) }
  let(:user1) { FactoryBot.create(:user) }
  let(:user2) { FactoryBot.create(:user) }
  let(:user3) { FactoryBot.create(:user) }
  let(:user4) { FactoryBot.create(:user) }

  describe 'GET /events/:event_id/tip' do
    let(:now) { Time.now }

    before do
      event.tips.create!(user: user1, point: 10)
      event.tips.create!(user: user2, point: -10)
      event.tips.create!(user: user3, point: 20)
      event.tips.create!(user: user4, point: -20)

      get "/events/#{event.id}/tips", headers: headers
    end

    specify do
      expect(status).to be 200
      expect(body).to contain_exactly(
        { 'user_id' => user1.id, 'point' => 10 },
        { 'user_id' => user2.id, 'point' => -10 },
        { 'user_id' => user3.id, 'point' => 20 },
        { 'user_id' => user4.id, 'point' => -20 },
      )
    end
  end

  describe 'POST /events/:event_id/tips' do
    let(:params) do
      {
        tips: [
          { user_id: user1.id, point: 10 },
          { user_id: user2.id, point: -10 },
          { user_id: user3.id, point: 30 },
          { user_id: user4.id, point: -30 },
        ]
      }
    end

    specify do
      post "/events/#{event.id}/tips", params: params, headers: headers

      expect(status).to be 200
      expect(event.tips.size).to be 4

      user1_tip = event.tips.find_by(user_id: user1.id)
      expect(user1_tip.point).to eq 10

      user2_tip = event.tips.find_by(user_id: user2.id)
      expect(user2_tip.point).to eq(-10)

      user3_tip = event.tips.find_by(user_id: user3.id)
      expect(user3_tip.point).to eq 30

      user4_tip = event.tips.find_by(user_id: user4.id)
      expect(user4_tip.point).to eq(-30)
    end

    context 'when tips are already exist' do
      before do
        event.tips.create!(user: user1, point: 1)
        event.tips.create!(user: user2, point: -1)
        event.tips.create!(user: user3, point: 2)
        event.tips.create!(user: user4, point: -2)
      end

      it 'should override data' do
        post "/events/#{event.id}/tips", params: params, headers: headers

        expect(status).to be 200
        expect(event.tips.size).to be 4

        user1_tip = event.tips.find_by(user_id: user1.id)
        expect(user1_tip.point).to eq 10

        user2_tip = event.tips.find_by(user_id: user2.id)
        expect(user2_tip.point).to eq(-10)

        user3_tip = event.tips.find_by(user_id: user3.id)
        expect(user3_tip.point).to eq 30

        user4_tip = event.tips.find_by(user_id: user4.id)
        expect(user4_tip.point).to eq(-30)
      end
    end
  end
end
