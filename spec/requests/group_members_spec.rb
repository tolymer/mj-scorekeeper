require 'rails_helper'

describe 'group members API' do
  let(:current_user) { FactoryBot.create(:user) }
  let(:headers) {
    token = Knock::AuthToken.new(payload: { sub: current_user.id }).token
    { Authorization: "Bearer #{token}" }
  }

  subject(:status) { response.status }
  subject(:body) { JSON.parse(response.body) }

  describe 'GET /groups/:group_id/members' do
    let(:group) { FactoryBot.create(:group) }
    let(:user1) { FactoryBot.create(:user) }
    let(:user2) { FactoryBot.create(:user) }

    before do
      group.members << user1
      group.members << user2
      get "/groups/#{group.id}/members", headers: headers
    end

    specify do
      expect(status).to be 200
      expect(body).to contain_exactly(
        { 'id' => user1.id, 'name' => user1.name },
        { 'id' => user2.id, 'name' => user2.name }
      )
    end
  end

  describe 'POST /groups/:group_id/members' do
    let(:group) { FactoryBot.create(:group) }
    before { post "/groups/#{group.id}/members", headers: headers }

    specify do
      expect(status).to be 201
      expect(body).to eq({ 'result' => 'ok' })
      expect(group.members.size).to eq 1
      expect(group.members.take).to eq current_user
    end
  end
end
