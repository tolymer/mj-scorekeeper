require 'rails_helper'

describe 'groups API' do
  let(:current_user) { FactoryBot.create(:user) }
  let(:headers) {
    token = Knock::AuthToken.new(payload: { sub: current_user.id }).token
    { Authorization: "Bearer #{token}" }
  }

  subject(:status) { response.status }
  subject(:body) { JSON.parse(response.body) }

  describe 'GET /groups/:id' do
    let(:group) { FactoryBot.create(:group) }
    before { get "/groups/#{group.id}", headers: headers }

    specify do
      expect(status).to be 200
      expect(body).to eq({ 'id' => group.id, 'name' => group.name, 'description' => group.description })
    end
  end

  describe 'POST /groups' do
    before { post "/groups", params: { name: 'foo', description: 'bar' }, headers: headers }

    specify do
      group = Group.take
      expect(status).to be 201
      expect(body).to eq({ 'id' => group.id, 'name' => group.name, 'description' => group.description })
      expect(group.members.take).to eq current_user
    end
  end
end
