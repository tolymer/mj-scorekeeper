require 'rails_helper'

describe 'event members API' do
  let(:current_user) { FactoryBot.create(:user) }
  let(:headers) {
    token = Knock::AuthToken.new(payload: { sub: current_user.id }).token
    { Authorization: "Bearer #{token}" }
  }

  subject(:status) { response.status }
  subject(:body) { JSON.parse(response.body) }

  describe 'GET /events/:event_id/members' do
    let(:event) { FactoryBot.create(:event) }
    let(:user1) { FactoryBot.create(:user) }
    let(:user2) { FactoryBot.create(:user) }

    before do
      event.members << user1
      event.members << user2
      get "/events/#{event.id}/members", headers: headers
    end

    specify do
      expect(status).to be 200
      expect(body).to contain_exactly(
        { 'id' => user1.id, 'name' => user1.name },
        { 'id' => user2.id, 'name' => user2.name }
      )
    end
  end

  describe 'POST /events/:event_id/members' do
    let(:event) { FactoryBot.create(:event) }
    let(:user1) { FactoryBot.create(:user) }
    let(:user2) { FactoryBot.create(:user) }
    before { post "/events/#{event.id}/members", params: { user_ids: [user1.id, user2.id] }, headers: headers }

    specify do
      expect(status).to be 201
      expect(body).to eq({ 'result' => 'ok' })
      expect(event.members.size).to eq 2
    end
  end
end
