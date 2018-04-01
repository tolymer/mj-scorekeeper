require 'rails_helper'

describe 'current_user API' do
  let(:current_user) { FactoryBot.create(:user) }
  let(:headers) {
    token = Knock::AuthToken.new(payload: { sub: current_user.id }).token
    { Authorization: "Bearer #{token}" }
  }

  subject(:status) { response.status }
  subject(:body) { JSON.parse(response.body) }

  describe 'GET /current_user' do
    before { get '/current_user', headers: headers }

    specify do
      expect(status).to be 200
      expect(body).to eq({ 'id' => current_user.id, 'name' => current_user.name })
    end
  end

  describe 'GET /current_user/groups' do
    let(:group1) { FactoryBot.create(:group) }
    let(:group2) { FactoryBot.create(:group) }
    let(:another_user) {FactoryBot.create(:user) }

    before do
      group1.members << current_user
      group2.members << another_user
      get '/current_user/groups', headers: headers
    end

    specify do
      expect(status).to be 200
      expect(body).to eq([{ 'id' => group1.id, 'name' => group1.name, 'description' => 'group description' }])
    end
  end
end
