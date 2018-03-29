require 'rails_helper'

describe 'users API' do
  subject(:status) { response.status }
  subject(:body) { JSON.parse(response.body) }

  describe 'GET /users/:id' do
    let(:current_user) { FactoryBot.create(:user) }
    let(:headers) {
      token = Knock::AuthToken.new(payload: { sub: current_user.id }).token
      { Authorization: "Bearer #{token}" }
    }

    before { get "/users/#{current_user.id}", headers: headers }

    specify do
      expect(status).to be 200
      expect(body).to eq({ 'id' => current_user.id, 'name' => current_user.name })
    end
  end

  describe 'POST /users' do
    before { post "/users", params: { name: 'foo', password: 'bar' }, headers: headers  }

    specify do
      user = User.take
      expect(status).to be 201
      expect(body).to eq({ 'id' => user.id, 'name' => user.name })
    end
  end
end
