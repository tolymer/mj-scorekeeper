require 'rails_helper'

describe 'current_user API' do
  let(:current_user) { FactoryBot.create(:user) }
  let(:headers) {
    token = Knock::AuthToken.new(payload: { sub: current_user.id }).token
    { Authorization: "Bearer #{token}" }
  }

  subject(:status) { response.status }
  subject(:body) { JSON.parse(response.body) }

  describe 'GET /current_users' do
    before { get '/current_user', headers: headers }

    specify do
      expect(status).to be 200
      expect(body).to eq({ 'id' => current_user.id, 'name' => current_user.name })
    end
  end
end
