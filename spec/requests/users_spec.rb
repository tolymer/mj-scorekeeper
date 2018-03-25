require 'rails_helper'

describe 'users API' do
  let(:current_user) { FactoryBot.create(:user) }
  let(:headers) {
    token = Knock::AuthToken.new(payload: { sub: current_user.id }).token
    { Authorization: "Bearer #{token}" }
  }

  subject(:status) { response.status }
  subject(:body) { JSON.parse(response.body) }

  describe 'GET /users/:id' do
    before { get "/users/#{current_user.id}", headers: headers }

    specify do
      expect(status).to be 200
      expect(body).to eq({ 'name' => current_user.name })
    end
  end
end
